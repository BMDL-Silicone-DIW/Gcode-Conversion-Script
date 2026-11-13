"""Write rendered records to a G-code file."""

from collections.abc import Iterable
from pathlib import Path
from tempfile import NamedTemporaryFile   # support of temporary file IO

from .model import GcodeRecord


def write_gcode(records: Iterable[GcodeRecord], destination: Path) -> None:
    """
    Stream records and replace the destination after the full write succeeds.
    
    Parameters
    ----------
    `records`: All the G code records to be written, in order.
    `destination`: The path to the output G code file (with filename **included**).
    """
    temporary_path = None
    try:
        with NamedTemporaryFile(
            mode="w",
            encoding="utf-8",
            newline="",
            dir=destination.parent,
            suffix=".tmp",
            delete=False,
        ) as stream:   # `newline=""` is important to avoid double newlines on Windows
            temporary_path = Path(stream.name)
            for record in records:
                stream.write(record.render())

        # Close the file before replacing the destination on Windows.
        temporary_path.replace(destination)
        temporary_path = None
    finally:
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)   # for files, this is removal
