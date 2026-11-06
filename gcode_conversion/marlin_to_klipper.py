"""Translation rules for the Marlin-to-Klipper direction."""

from decimal import Decimal   # Precise base-10 decimal arithmetic, avoiding floating-point errors

from gcodeparser import GcodeLine

from .model import GcodeRecord


def translate_dwell(record: GcodeRecord) -> None:
    """Convert a Marlin G4 S (seconds) dwell to Klipper G4 P (milliseconds) in place."""
    command = record.command
    if not isinstance(command, GcodeLine) or command.command != ("G", 4):
        return
    if "S" not in command.params:
        return

    seconds = command.params["S"]
    if isinstance(seconds, bool) or not isinstance(seconds, (int, float)):
        # Always remember `bool` is a subclass of `int`!
        raise ValueError(f"{record.source}:{record.line_number}: G4 S requires a number")

    duration = Decimal(str(seconds))
    if not duration.is_finite() or duration < 0:
        raise ValueError(f"{record.source}:{record.line_number}: invalid G4 S duration")

    # Marlin gives S precedence over P and Klipper only recognizes P.
    command.params["P"] = int(duration * 1000)
    del command.params["S"]
