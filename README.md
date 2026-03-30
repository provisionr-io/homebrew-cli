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

## Release channels

Provisionr uses a cascading channel model inspired by how operating systems and browsers ship updates. Each channel receives a different subset of tagged releases, letting you choose your own trade-off between freshness and stability.

Learn more in the [Release Channel documentation](https://docs.provisionr.io/releases/upgrade/channels).

| Channel | Formula | Receives | Intended for |
| --- | --- | --- | --- |
| **RC** | `provisionr-workspace@rc` | Every tag, including pre-releases (`26.05.0-rc1`) | Early adopters and internal testing |
| **Rapid** | `provisionr-workspace@rapid` | All stable tags (`26.04.0`, `26.04.1`) | Teams that want new features quickly |
| **Regular** | `provisionr-workspace@regular` | Monthly releases (`YY.MM.0`) and their security patches (`YY.MM.0.z`) | Most users |
| **Stable** | `provisionr-workspace@stable` | Regular releases delayed by one month for broader exposure (coming in 2026-Q3) | Risk-averse environments |

The default `provisionr-workspace` formula tracks the **rapid** channel that is the default for new workspaces.

### Release schedule

- **RC** — published on every tag push (no fixed cadence)
- **Rapid** — every Tuesday
- **Regular** — second Tuesday of each month
- **Stable** — one month after the corresponding Regular release (coming in 2026-Q3)

### How channels cascade

When a new tag is pushed, releases flow through channels sequentially:

```text
tag pushed
  --> rc        (all tags)
    --> rapid   (stable tags only)
      --> regular (YY.MM.0 monthly releases only)
```

A pre-release tag like `26.05.0-rc1` lands in RC only. Once `26.05.0` ships, it cascades through RC, then Rapid, then Regular. A weekly patch tag like `26.04.1` reaches RC and Rapid but skips Regular (since Regular only tracks `.0` monthly releases and their `.0.z` security patches).

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
26.04.0        # April 2026 monthly release (2nd Tuesday)  --> rc, rapid, regular
26.04.0.1      # Security patch for 26.04.0                --> rc, rapid, regular
26.04.1        # Weekly release (3rd Tuesday)               --> rc, rapid
26.04.2        # Weekly release (4th Tuesday)               --> rc, rapid
26.05.0-rc1    # Release candidate for May                  --> rc only
```

The fourth octet (`YY.MM.0.z`) is reserved for security patches against a monthly release, ensuring Regular channel users receive critical fixes without pulling in unrelated changes.

### Switching channels

Only one channel can be installed at a time. Use `--force` to replace the current channel:

```sh
# Switch to the RC channel
brew install --force provisionr-io/cli/provisionr-workspace@rc

# Switch to rapid
brew install --force provisionr-io/cli/provisionr-workspace@rapid

# Back to regular
brew install --force provisionr-io/cli/provisionr-workspace@regular
```

## Upgrading

```sh
brew update
brew upgrade provisionr-workspace
```

Homebrew will pull the latest version available on your installed channel.

## Uninstalling

```sh
brew uninstall provisionr-workspace
```

## How releases work

Releases are fully automated. When a version tag is pushed to the source repository, the CI pipeline:

1. Compiles a self-contained PHAR binary
2. Computes a SHA-256 checksum of the artifact
3. Creates a GitHub release in this repository with the binary attached
4. Updates the appropriate formula(e) with the new download URL, checksum, and version

Each channel's formula is updated in sequence — RC first, then Rapid (if eligible), then Regular (if eligible) — so a formula is never updated until the previous channel has been successfully published.

## Verifying a release

Every formula pins a `sha256` checksum. Homebrew verifies this automatically during install, so you can confirm the binary you received matches what was built in CI.

## Support

Visit [docs.provisionr.io/support/help](https://docs.provisionr.io/support/help) for assistance.

## License

Apache-2.0 — Copyright Provisionr LLC
