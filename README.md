# Gcode Conversion Script

A conversion script among Cura-generated Gcode, Marlin-style Gcode and Klipper-style Gcode. The Marlin to Klipper conversion is mostly workarounds for incompatibility, and Cura to Marlin is to refactor [legacy MATLAB modifier by Leo Allentoff](https://drive.google.com/drive/folders/1YQsNO904lsQEgFjKxI0ceAudtEn35qz_?usp=drive_link).

## Background

Silicone DIW is vastly different from traditional plastic 3D printing due to entirely different material properties. Although we used Cura for initial Gcode generation, the generated code cannot be directly used for printing, and must be modified, especially extrusion parameters. Originally, [Leo Allentoff's MATLAB modifier](https://drive.google.com/drive/folders/1YQsNO904lsQEgFjKxI0ceAudtEn35qz_?usp=drive_link) does this job.

:exclamation: However, the modified Gcode is aimed for Marlin, which has a bunch of incompatibilities with Klipper, especially in terms of T commands and many non-standard features (for details, please refer to [Klipper G-Codes documentation](https://www.klipper3d.org/G-Codes.html#g-code-commands)).

:star: Also, [James Lorenz](https://github.com/orgs/BMDL-Silicone-DIW/people/jpeckhamlorenz) would like to have the legacy MATLAB modifier been refactored in Python for better support for further customizations or new features via third-party packages or libraries.

To address all these needs altogether, this repository is created and will be developed gradually. The ultimate wish is to implement all the conversions among Cura, Marlin and Klipper, with **a launcher specifying the source and destination**.

## Status Quo

:hourglass: We are developing a Python script to convert Marlin-style Gcode to Klipper style.

## Dependencies and Usage

This section is a brief guide on how to recreate the virtual environment and how to run the script.

### Virtual environment reproduction

This project requires Python 3.14 or later and uses [`uv`](https://docs.astral.sh/uv/) as the package manager. Please refer to the [installation guide](https://docs.astral.sh/uv/getting-started/installation/) with respect to your own operating system.

After successful installation of `uv` (can be verified via `uv --version`), run

```shell
uv sync --locked
```

in the **root directory** of the project repository to install the dependencies from `uv.lock`.

### Direct script execution

From the repository root, run the conversion with an input path and a separate output path.

```shell
uv run python -m gcode_conversion --from marlin --to klipper "input.gcode" "output.gcode"
```

**Replace the example filenames** with your own paths. The output directory **must already exist**. An existing output file is **replaced** after a successful conversion.

:exclamation: Run `uv run python -m gcode_conversion --help` for usage, especially when in doubt.

:hourglass: Right now, only `--from marlin --to klipper` is supported. Other conversion paths will be developed later.

### Imported as a module

Python scripts run from the repository root can import the reader, conversion rules, and writer directly, as shown in the following demo.

```python
# Suppose the file is created on repository root
from contextlib import closing   # automatically close files
from pathlib import Path

from gcode_conversion.marlin_to_klipper import convert_records
from gcode_conversion.reader import read_gcode
from gcode_conversion.writer import write_gcode

with closing(read_gcode("input.gcode")) as records:
    write_gcode(convert_records(records), Path("output.gcode"))
```
