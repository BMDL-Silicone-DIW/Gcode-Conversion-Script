"""Read Marlin-style files using gcodeparser's structured GcodeLine objects.

The initial input subset is one numbered G/M/T command per line, numeric
parameters, flags and semicolon comments. This reader checks syntax, not whether
a command or parameter combination is supported by the printer.
"""

from collections.abc import Iterator
import math
from pathlib import Path

from gcodeparser import parse_gcode_lines
# These implementation constants belong to our pinned gcodeparser 0.3.0.
from gcodeparser import GCODE_LINE_PATTERN, PARAMS_PATTERN
# Use official grammar and parser as much as possible, with custom wrappers

from .model import GcodeRecord   # class from `model.py`


class GcodeReadError(ValueError):
    """
    An input problem located at a particular source line, derived from official `ValueError`.
    """

    def __init__(self, source: Path, line_number: int, message: str):
        self.source = source
        self.line_number = line_number
        super().__init__(f"{source}:{line_number}: {message}")
        # `super()` is used to call the constructor of the parent class (official `ValueError`)


def parse_line(raw: str, *, source: Path, line_number: int) -> GcodeRecord:
    """
    Parse the command and keep its comment and line ending separately.
    """
    if line_number < 1:
        raise ValueError("line_number must be one-based")

    text = raw.removesuffix("\n").removesuffix("\r")
    line_ending = raw[len(text):]
    if line_number == 1:
        text = text.removeprefix("\ufeff")
        # Some editors add a UTF-8 byte order mark at the start of a file.
    if any((ord(char) < 32 and char != "\t") or ord(char) == 127 for char in text):
        # ordinal < 32 is control character, except tab (ASCII 9); ordinal 127 is DEL
        raise GcodeReadError(source, line_number, "unexpected control character")

    body, marker, comment_text = text.partition(";")
    comment = marker + comment_text
    body = body.strip()
    if not body:
        return GcodeRecord(source, line_number, None, comment, line_ending)

    # Require the parser's pattern to cover the whole command body.
    match = GCODE_LINE_PATTERN.fullmatch(body)
    """
    This match forms multiple groups, and the first 3 groups are relevant here.
    Group 1: command letter; Group 2: command number; Group 3: parameter text.
    """
    if match is None or match.group(1) is None:
        raise GcodeReadError(source, line_number, "unsupported command syntax")

    # A dictionary would silently overwrite repeated parameter names.
    names = [token[0].upper() for token in PARAMS_PATTERN.findall(match.group(3))]
    if len(names) != len(set(names)):   # `set` removes duplicates
        raise GcodeReadError(source, line_number, "duplicate parameter")

    try:
        parsed_lines = list(parse_gcode_lines(body))   # `list` converts the iterator to a list of objects
    except (ValueError, OverflowError) as error:
        raise GcodeReadError(source, line_number, "parser could not read this line") from error
        # The `from error` part preserves the original exception as the cause of this new exception.
    if len(parsed_lines) != 1:
        raise GcodeReadError(source, line_number, "expected one command per line")
    command = parsed_lines[0]
    for value in command.params.values():
        if not isinstance(value, (int, float)):   # `bool` is a subclass of `int`, so it is included here
            raise GcodeReadError(source, line_number, "expected numeric parameters or flags")
        if isinstance(value, float) and not math.isfinite(value):
            raise GcodeReadError(source, line_number, "non-finite parameter value")

    return GcodeRecord(source, line_number, command, comment, line_ending)


def read_gcode(path: str | Path) -> Iterator[GcodeRecord]:
    """
    Yield records from a UTF-8 file, preserving blank lines and line endings.

    Reading is lazy: errors can occur during iteration. Exhaust the iterator
    before treating the whole file as read successfully. Use list(read_gcode(path))
    when the caller explicitly wants all records in memory.
    """
    source = Path(path)
    with source.open(encoding="utf-8", newline="") as stream:
        for line_number, raw in enumerate(stream, start=1):
            yield parse_line(raw, source=source, line_number=line_number)
            # `yield` is used to produce a sequence of values lazily, allowing the caller to iterate over them one at a time.
