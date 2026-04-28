# Homebrew devcontainer-rs

This tap publishes the Homebrew formula for the native Rust `devcontainer` CLI from
[`jooh/devcontainer-rs`](https://github.com/jooh/devcontainer-rs).

## Install

```bash
brew install jooh/devcontainer-rs/devcontainer-rs
devcontainer --version
```

Homebrew maps this repository, `jooh/homebrew-devcontainer-rs`, to the tap
shorthand `jooh/devcontainer-rs`.

## Formula updates

The tap owns its formula publishing workflow. A scheduled/manual GitHub Actions
workflow reads the latest public `jooh/devcontainer-rs` release, renders
`Formula/devcontainer-rs.rb`, and commits changes back to this repository with
this repository's short-lived `GITHUB_TOKEN`.

No personal access token, GitHub App private key, or cross-repository write
secret is required.
