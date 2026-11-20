"""XY rotation and translation for linear moves, independent of conversion rules."""

from dataclasses import dataclass
import math

from gcodeparser import GcodeLine


@dataclass(frozen=True)
class XYTransform:
    """Rotate clockwise by 90 degrees if requested, then translate in millimeters."""

    x_offset: float = 0
    y_offset: float = 0
    clockwise: bool = False   # a clockwise 90-degree rotation

    def __post_init__(self) -> None:
        if any(type(value) not in (int, float) or not math.isfinite(value)
               for value in (self.x_offset, self.y_offset)):
            raise ValueError("XY offsets must be finite numbers")

    def apply(self, command: GcodeLine, *, absolute: bool) -> None:
        """Modify a G0/G1 in place; the caller supplies the current G90/G91 mode.

        An omitted axis stays omitted, swapping X and Y when rotating.
        Use a move specifying both axes when switching between transforms.
        Z, E, F and all other parameters are left unchanged.
        """
        if command.command not in (("G", 0), ("G", 1)):
            raise ValueError("XY transforms currently support only G0 and G1")

        params = command.params
        x, y = params.get("X"), params.get("Y")
        if any(type(value) not in (int, float) or not math.isfinite(value)
               for axis, value in (("X", x), ("Y", y)) if axis in params):
            raise ValueError("XY coordinates must be finite numbers")

        # For absolute positions: X_new = Y_old + dx, Y_new = -X_old + dy.
        # Relative moves are displacements, so they rotate without translation.
        if self.clockwise:
            x, y = y, None if x is None else -x
            # Remove the old axis names before writing their swapped counterparts.
            params.pop("X", None)   # second argument is default return value if key is not found
            params.pop("Y", None)

        if x is not None:
            params["X"] = x + self.x_offset if absolute else x
        if y is not None:
            params["Y"] = y + self.y_offset if absolute else y
