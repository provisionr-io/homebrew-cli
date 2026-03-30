# Provisionr Homebrew Tap

Homebrew formulae for the [Provisionr](https://provisionr.io) CLI tools.

## Installation

```sh
brew tap provisionr-io/cli
brew install provisionr-workspace
```

After installation, the CLI is available as both `provisionr-workspace` and `prv`:

```sh
provisionr-workspace --version
prv --version
```

## Requirements

- **PHP 8.3 or higher** — the CLI is distributed as a PHAR archive and requires the PHP interpreter at runtime. The formula will check for a compatible version during installation.
- PHP can be provided by Homebrew's `php` formula or by [Laravel Herd](https://herd.laravel.com). If Herd is detected, the Homebrew `php` dependency is skipped automatically.

## Formulas

| Formula | Purpose |
| --- | --- |
| `provisionr-workspace` | Production formula. Tracks stable releases. Used by all customers. |
| `provisionr-workspace-nightly` | Internal/dogfooding formula. Tracks latest RC tags. Not customer-facing. |

Only one formula can be installed at a time.

## Release channels

Release channels (Rapid, Regular, Stable) are a **workspace property** managed in [HQ](https://hq.provisionr.io), not a CLI property. The CLI binary is the same across all channels — channel selection determines when your workspace receives new platform features.

Learn more in the [Release Channel documentation](https://docs.provisionr.io/releases/upgrade/channels).

### Versioning scheme

Provisionr follows [CalVer](https://calver.org/) based on `YY.MM`:

```text
YY.MM.week[.security][-prerelease]
```

- **YY** — year (e.g. `26` for 2026)
- **MM** — month (e.g. `04` for April)
- **week** — weekly release within the month, where `.0` is the monthly release on the second Tuesday, `.1` is the third Tuesday, `.2` is the fourth Tuesday, etc.
- **security** — incremented from `.0` for security patches against a specific version

```text
26.04.0        # April 2026 monthly release (2nd Tuesday)
26.04.0.1      # Security patch for 26.04.0
26.04.1        # Weekly release (3rd Tuesday)
26.04.2        # Weekly release (4th Tuesday)
26.05.0-rc1    # Release candidate for May
```

The fourth octet (`YY.MM.0.z`) is reserved for security patches against a monthly release.

## Upgrading

```sh
brew update
brew upgrade provisionr-workspace
```

## Uninstalling

```sh
brew uninstall provisionr-workspace
```

## How releases work

Releases are fully automated. When a version tag is pushed to the source repository, the CI pipeline:

1. Compiles a self-contained PHAR binary
2. Computes a SHA-256 checksum of the artifact
3. Creates a GitHub release in this repository with the binary attached
4. Updates the appropriate formula with the new download URL, checksum, and version

## Verifying a release

Every formula pins a `sha256` checksum. Homebrew verifies this automatically during install, so you can confirm the binary you received matches what was built in CI.

## Support

Visit [docs.provisionr.io/support/help](https://docs.provisionr.io/support/help) for assistance.

## License

Apache-2.0 — Copyright Provisionr LLC
