"""Command-line entry point for the G-code converter."""

import argparse
from contextlib import closing   # works with `with` block to autoclose files
from pathlib import Path

from .marlin_to_klipper import convert_records as marlin_to_klipper
from .reader import read_gcode
from .writer import write_gcode


# Mapping of supported conversion directions to their corresponding functions.
_CONVERTERS = {("marlin", "klipper"): marlin_to_klipper}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Convert G-code for offline review. Supported direction: marlin to klipper."
    )
    parser.add_argument("--from", dest="source_format", required=True, help="Input G-code format")
    # `dest` is used to specify the attribute name in the `args` object, since `from` is a reserved keyword in Python.
    parser.add_argument("--to", dest="target_format", required=True, help="Output G-code format")
    parser.add_argument("input", type=Path, help="Input G-code file")
    parser.add_argument("output", type=Path, help="Destination file (replaced on success)")
    args = parser.parse_args(argv)

    converter = _CONVERTERS.get((args.source_format, args.target_format))
    if converter is None:
        parser.error(f"unsupported conversion from {args.source_format} to {args.target_format}")

    source, destination = args.input, args.output
    try:
        if source.resolve() == destination.resolve() or (
            destination.exists() and source.samefile(destination)
        ):   # `.resolve()` is used to get the absolute path, and `samefile()` checks if two paths refer to the same file.
            parser.error("input and output must be different files")

        with closing(read_gcode(source)) as records:
            write_gcode(converter(records), destination)
    except (OSError, ValueError) as error:
        parser.exit(1, f"{parser.prog}: {error}\n")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
