# Provisionr Homebrew Tap

Homebrew formulae for the [Provisionr](https://provisionr.io) CLI tools.

## Installation

```sh
brew tap provisionr-io/cli
brew install provisionr-workspace   # or: brew install provisionr
```

After installation, the CLI is available as both `provisionr-workspace` and `prv`:

```sh
provisionr-workspace --version
prv --version
```

## Formulas

| Formula | Alias | Purpose |
| --- | --- | --- |
| `provisionr-workspace` | `provisionr` | Production formula. Tracks stable releases. Used by all customers. |
| `provisionr-workspace-nightly` | `provisionr-nightly` | Tracks latest RC tags. Used for dogfooding and customers who need early access to a feature or patch before GA. |

Both formulas can be installed side-by-side. The nightly formula installs as `provisionr-workspace-nightly` / `prv-nightly`.

## Release channels

Release channels (Rapid, Regular, Stable) are a **workspace property** managed in [HQ](https://hq.provisionr.io), not a CLI property. The CLI binary is the same across all channels — channel selection determines when your workspace receives new platform features.

We always release a new minor version of the CLI client on the second Tuesday of the month alongside the Workspace API to provide a parity of features. The CLI client may get incremental updates throughout the month, however any commands that are incompatible will simply show an API error message.

Learn more in the [Release Channel documentation](https://docs.provisionr.io/releases/upgrade/channels).

### Versioning scheme

Provisionr follows [CalVer](https://calver.org/) based on `YY.MM`:

```text
YY.MM.patch[-prerelease]
```

- **YY** — year (e.g. `26` for 2026)
- **MM** — month (e.g. `04` for April)
- **patch** — incrementing patch or minor feature enhancement month, where `.0` is the monthly release on the second Tuesday, `.1` is the first patch release.

```text
26.04.0        # April 2026 monthly release (2nd Tuesday)
26.04.1        # Weekly release (3rd Tuesday)
26.04.2        # Weekly release (4th Tuesday)
26.05.0-rc1    # Release candidate for May
```

### Security Patches

If a security vulnerability is detected, the fix will be incorporated into one of the upcoming patch releases.

When authenticating with your workspace, you will use a refresh token to get a short-lived access token (usually 60 minutes).

When requesting a new access token (behind the scenes) every 60 minutes, the CLI client sends the version of the CLI client running. If it is a known vulnerable version, authentication will fail and a message will be displayed to upgrade. This provides a boring and easy solution to not allow vulnerable CLI client versions to exploit data on the server side.

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
