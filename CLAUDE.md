# CLAUDE.md

## Project overview

This repo is a Homebrew tap (`provisionr-io/cli`) that distributes the Provisionr Workspace CLI as a standalone binary (built with phpacker) via two formulas: `provisionr-workspace` (production) and `provisionr-workspace-nightly` (dogfooding and early access). Each formula also has a shorter alias (`provisionr` and `provisionr-nightly`) for discoverability.

## Key details

- The CLI is a standalone binary built with phpacker — no PHP runtime dependency is required.
- Binaries are provided for four platform/architecture combinations: macOS ARM, macOS x64, Linux ARM, and Linux x64.
- The two formulas can be installed side-by-side. The nightly formula installs as `provisionr-workspace-nightly` / `prv-nightly` to avoid collisions with the stable formula.
- The `prv` symlink is created alongside `provisionr-workspace` in the stable formula; the nightly formula creates `prv-nightly` alongside `provisionr-workspace-nightly`.
- Release channels (Rapid, Regular, Stable) are a workspace property managed in HQ, not a CLI property. The CLI binary does not differ between channels.

## Formula structure

Both formulas in `Formula/` follow the same pattern:

- `on_macos`/`on_linux` with `on_arm`/`on_intel` blocks for platform-specific URLs and SHA256s
- `bin.install` the binary (renamed to `provisionr-workspace` or `provisionr-workspace-nightly`) + symlink to `prv` or `prv-nightly`
- A version test in the `test` block

When editing one formula, apply the same change to both.

## Release process

- Provisionr employees can see the pipeline in the `prv-prd-src-wks-cli` repository.
- Formula URLs point to GitHub releases under this repo
- `sha256` and `version` fields are updated per release
- `provisionr-workspace` tracks stable releases
- `provisionr-workspace-nightly` tracks RC tags (e.g. `26.04.0-rc1`)
