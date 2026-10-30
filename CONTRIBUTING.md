# Note for Contributors and Developers

Here are some conventions potential contributors or developers should follow. This note may be expanded later.

## :twisted_rightwards_arrows: Branch Description

Here are some general descriptions of the branches:

- `main` is the main branch for **verified** versions only. **:exclamation: Do not directly commit to `main` unless you know what you are doing!**
- `dev` is the overall development branch, and `dev/<feature>` branches are the actual development branches for corresponding features.
  - The feature branches will be merged to `dev` for combined testing, and if verified, merge into `main` via **pull requests**.
- `test` branch is reserved for creating testcases and do the tests. **CI** will also be developed in this branch.
  - Changes on feature or `dev` branches will be merged here for testing, and if anything breaks, we go back to corresponding `dev` or feature branches for correction.

## :mailbox: Commit Message

The standard format is `<type>[optional scope]: <description>`. For details, please refer to [coventional commit guide](https://www.conventionalcommits.org/en/v1.0.0/).

What needs special attention is the `[optional scope]` here. When this scope is absent, **CI will be skipped**; otherwise, a proper scope in this repository is defined as **`[<source> <destination>]`**, indicating the **Gcode conversion direction tested in CI**. Both keys are **positional parameters** with acceptable values among **`cura`, `marlin` or `klipper`**, all letters being **lowercase**.
