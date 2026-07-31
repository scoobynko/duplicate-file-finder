# homebrew-whirr

Homebrew tap for [whirr](https://github.com/scoobynko/whirr) — a macOS system
dashboard that lives in your terminal.

```bash
brew install scoobynko/whirr/whirr
```

## About this repo

`Formula/whirr.rb` is **generated and committed automatically** by
[cargo-dist](https://opensource.axo.dev/cargo-dist/) when a `v*` tag is pushed
to the main repository. Don't edit it by hand — the next release overwrites it.

Apple Silicon only: whirr reads IOReport power channels that don't exist on
Intel Macs, so the formula refuses to install there rather than installing
something that crashes on launch.
