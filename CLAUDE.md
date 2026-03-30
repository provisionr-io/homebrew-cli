# CLAUDE.md

## Project overview

This repo is a Homebrew tap (`provisionr-io/cli`) that distributes the Provisionr Workspace CLI as a PHAR binary across four release channels: stable, regular, rc, and rapid.

## Key details

- The CLI is a PHP Archive (PHAR) built using Laravel Zero — it requires the PHP runtime to execute, hence the `depends_on "php"` in each formula.
- All formulas enforce a minimum of PHP 8.3 at install time via a version check in the `install` block.
- Each channel formula conflicts with the others so only one can be installed at a time.
- The `prv` symlink is created alongside `provisionr-workspace` in every formula.

## Formula structure

All four formulas in `Formula/` follow the same pattern:
- `depends_on "php"` (with a runtime PHP 8.3+ check)
- `conflicts_with` the other three channel formulas
- `bin.install` the binary + symlink to `prv`
- A version test in the `test` block

When editing one formula, apply the same change to all four.

## Release process

- Provisionr employees can see the pipeline in the `prv-prd-src-wks-cli` repository.
- Formula URLs point to GitHub releases under this repo
- `sha256` and `version` fields are updated per release
