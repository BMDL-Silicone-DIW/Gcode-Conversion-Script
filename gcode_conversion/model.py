"""A G-code command and the information needed to write its line."""

from dataclasses import dataclass, field
from decimal import Decimal
from pathlib import Path
from shlex import quote

from gcodeparser import GcodeLine


@dataclass   # resemble a struct, without the need to write `__init__` explicitly
class KlipperCommand:
    """A manually constructed named command with editable parameters."""

    name: str
    params: dict[str, str | int | float] = field(default_factory=dict)

    @property   # decorator to make a method behave like an attribute (read-only if no setter is defined)
    def gcode_str(self) -> str:
        """Render Klipper's NAME=value arguments."""
        words = [self.name]
        for name, value in self.params.items():
            words.append(f"{name}={quote(str(value))}")
            """
            `quote` makes the value a single token for Klipper's shell-style argument parser.
            For example, words separated by spaces and double quotes will be single-quoted as a single token.
            """
        return " ".join(words)


@dataclass
class GcodeRecord:
    """A numbered command, a generated Klipper command, or a line without a command."""

    source: Path
    """The file from which this line was read."""
    line_number: int
    """The one-based line number in the source file."""
    command: GcodeLine | KlipperCommand | str | None
    """The parsed command, a generated Klipper command, or None for a blank or comment-only line."""
    comment: str
    """The comment text, including the leading semicolon if present."""
    line_ending: str
    """The line ending, including the newline character(s)."""

    def render(self) -> str:
        """Write the current command with its original comment and line ending."""
        if isinstance(self.command, GcodeLine):
            words = [self.command.command_str]
            for name, value in self.command.params.items():
                if value is True:
                    words.append(name)
                elif isinstance(value, float):
                    # Klipper can read the E in scientific notation as an axis.
                    words.append(name + format(Decimal(str(value)), "f"))
                else:
                    words.append(name + str(value))
            body = " ".join(words)
        elif isinstance(self.command, KlipperCommand):
            body = self.command.gcode_str
        else:
            body = self.command or ""

        separator = " " if body and self.comment else ""
        return body + separator + self.comment + self.line_ending
