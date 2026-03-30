# CLAUDE.md

## Project overview

This repo is a Homebrew tap (`provisionr-io/cli`) that distributes the Provisionr Workspace CLI as a PHAR binary via two formulas: `provisionr-workspace` (production) and `provisionr-workspace-nightly` (internal/dogfooding).

## Key details

- The CLI is a PHP Archive (PHAR) built using Laravel Zero — it requires the PHP runtime to execute.
- PHP can be provided by Homebrew's `php` formula or by Laravel Herd (`herd`). If Herd is detected, the `php` dependency is skipped.
- All formulas enforce a minimum of PHP 8.3 at install time via a version check in the `install` block.
- The two formulas conflict with each other so only one can be installed at a time.
- The `prv` symlink is created alongside `provisionr-workspace` in every formula.
- Release channels (Rapid, Regular, Stable) are a workspace property managed in HQ, not a CLI property. The CLI binary does not differ between channels.

## Formula structure

Both formulas in `Formula/` follow the same pattern:

- `depends_on "php"` (skipped if Herd is detected; with a runtime PHP 8.3+ check)
- `conflicts_with` the other formula
- `bin.install` the binary + symlink to `prv`
- A version test in the `test` block

When editing one formula, apply the same change to both.

## Release process

- Provisionr employees can see the pipeline in the `prv-prd-src-wks-cli` repository.
- Formula URLs point to GitHub releases under this repo
- `sha256` and `version` fields are updated per release
- `provisionr-workspace` tracks stable releases
- `provisionr-workspace-nightly` tracks RC tags (e.g. `26.04.0-rc1`)
