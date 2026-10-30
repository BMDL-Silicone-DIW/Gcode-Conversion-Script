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

:hourglass: We are still developing the scripts. We will fill this part once we figure this out.
