"""Translation rules for the Marlin-to-Klipper direction."""

from dataclasses import dataclass, field
from decimal import Decimal   # Precise base-10 decimal arithmetic, avoiding floating-point errors
from typing import Literal

from gcodeparser import GcodeLine

from .model import GcodeRecord


type Material = Literal["silicone", "plastic"]

# MIXING_VIRTUAL_TOOLS in the legacy Marlin configuration.
_VIRTUAL_TOOL_COUNT = 16


@dataclass
class _SavedMix:
    """Store the actual currently saved mix of the virtual tool."""
    material: Material
    weights: dict[int, int | float]


@dataclass
class ToolState:
    """Store pending weights and the committed mix for each virtual tool."""

    # Data members with `_` prefix are intended for internal use and not part of the public interface.
    _pending_weights: dict[int, int | float] = field(default_factory=dict, init=False)
    _saved_mixes: dict[int, _SavedMix] = field(default_factory=dict, init=False)
    _selected_slot: int | None = field(default=None, init=False)

    @property
    def active_tool(self) -> int | None:
        return self._selected_slot

    @property
    def _active_mix(self) -> _SavedMix | None:
        if self._selected_slot is None:
            return None
        return self._saved_mixes.get(self._selected_slot)   # use `.get()`, not `[]`, to avoid KeyError if the slot is undefined

    @property
    def active_material(self) -> Material | None:
        """Return the material of the selected tool once its mix is validated."""
        mix = self._active_mix
        return mix.material if mix is not None else None

    def get_mix_weights(self, *, pending: bool = False) -> dict[int, int | float]:
        """Copy pending weights or the active tool's committed relative weights."""
        if pending:
            return self._pending_weights.copy()   # deep copy to avoid accidental mutation of the internal state
        mix = self._active_mix
        return mix.weights.copy() if mix is not None else {}

    def set_pending_weight(self, channel: int, weight: int | float) -> None:
        """Stage a validated channel weight without changing a saved mix."""
        self._pending_weights[channel] = weight

    def commit_mix(self, slot: int, material: Material) -> None:
        """Save an independent copy of the validated pending mix in this slot."""
        self._saved_mixes[slot] = _SavedMix(material, self._pending_weights.copy())

    def select_tool(self, slot: int) -> None:
        """Direct assignment to the internal variable, bypassing validation."""
        self._selected_slot = slot


# Functions starting with `_` are intended for internal use and not part of the public interface.

def _set_mix_weight(command: GcodeLine, state: ToolState, location: str) -> None:
    """
    Validate an M163 command and set the pending mix weight for a channel.
    **Caution:** This function does not check if the command is actually M163!
    """
    channel, weight = command.params.get("S"), command.params.get("P")
    if type(channel) is not int or channel not in (0, 1, 2):
        raise ValueError(f"{location}: M163 requires channel S0, S1 or S2")
    if type(weight) not in (int, float) or not 0 <= weight < float("inf"):
        raise ValueError(f"{location}: M163 requires a finite nonnegative P")
    state.set_pending_weight(channel, weight)


def _save_mix(command: GcodeLine, state: ToolState, location: str) -> None:
    """
    Classify the pending mix and commit it to the requested slot.
    **Caution:** This function does not check if the command is actually M164!
    """
    slot = command.params.get("S")
    if type(slot) is not int or not 0 <= slot < _VIRTUAL_TOOL_COUNT:
        raise ValueError(
            f"{location}: M164 requires a virtual tool slot S0 through S{_VIRTUAL_TOOL_COUNT - 1}"
        )
    weights = state.get_mix_weights(pending=True)
    if weights.keys() != {0, 1, 2}:
        raise ValueError(f"{location}: define all three mix channels before M164")

    pump0, pump1, plastic = (weights[channel] for channel in range(3))
    if pump0 == pump1 == 0 and plastic > 0:
        state.commit_mix(slot, "plastic")
    elif pump0 == pump1 > 0 and plastic == 0:
        state.commit_mix(slot, "silicone")
    else:
        raise ValueError(f"{location}: unsupported mix for T{slot}")


def _select_tool(slot: int | None, state: ToolState, location: str) -> None:
    """
    Set the active tool to a virtual tool slot.
    **Caution:** This function does not check if the command is actually Tn!
    """
    if type(slot) is not int or not 0 <= slot < _VIRTUAL_TOOL_COUNT:
        raise ValueError(f"{location}: expected a tool from T0 through T{_VIRTUAL_TOOL_COUNT - 1}")
    # The insole files select T5 before they write the mix definitions.
    state.select_tool(slot)


def _translate_dwell(command: GcodeLine, location: str) -> None:
    """
    Convert a Marlin G4 S (seconds) dwell to Klipper G4 P (milliseconds) in place.
    **Caution:** This function does not check if the command is actually G4!"""
    if "S" not in command.params:
        return

    seconds = command.params["S"]
    if isinstance(seconds, bool) or not isinstance(seconds, (int, float)):
        # Always remember `bool` is a subclass of `int`!
        raise ValueError(f"{location}: G4 S requires a number")

    duration = Decimal(str(seconds))
    if not duration.is_finite() or duration < 0:
        raise ValueError(f"{location}: invalid G4 S duration")

    # Marlin gives S precedence over P and Klipper only recognizes P.
    command.params["P"] = int(duration * 1000)
    del command.params["S"]


# Public functions for external use

def apply_rules(record: GcodeRecord, state: ToolState) -> None:
    """Apply the implemented rules to one record in source order."""
    command = record.command
    if not isinstance(command, GcodeLine):
        return

    location = f"{record.source}:{record.line_number}"
    match command.command:
        case ("G", 4):
            _translate_dwell(command, location)
        case ("M", 163):
            _set_mix_weight(command, state, location)
        case ("M", 164):
            _save_mix(command, state, location)
        case ("T", slot):
            _select_tool(slot, state, location)
        case ("G", 0 | 1) if "E" in command.params:
            if state.active_material is None:
                raise ValueError(f"{location}: E move before the selected mix is defined")
