cask "openagentd" do
  version "3.50.0"
  sha256 "3f932956ac15b4a14847c7ca23b13fb743eeff1ff88856cedbc7f29a31933a2a"

  url "https://github.com/lthoangg/openagentd/releases/download/v3.50.0/OpenAgentd_3.50.0_aarch64.dmg"
  name "OpenAgentd"
  desc "Desktop app for a local coding agent you can watch work"
  homepage "https://openagentd.dev"

  # Apple Silicon only. release-desktop.yml does not build an
  # Intel .dmg today; Intel Mac users should install the CLI
  # Formula instead (brew install openagentd).
  depends_on arch: :arm64
  depends_on macos: :big_sur

  livecheck do
    url :url
    # Match v<X.Y.Z> tags (the unified release tag since
    # 1.0.9). Older v*-desktop tags are intentionally
    # ignored — the cask only tracks the new naming scheme
    # forward.
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  auto_updates true

  app "OpenAgentd.app"

  # The app and DMG are Developer ID signed, notarized and
  # stapled by release-desktop.yml, so Gatekeeper accepts the
  # download as is. Stripping the quarantine flag (a post-install hook)
  # would skip that check, and nothing may re-sign the app.

  # Intentionally no zap block. brew uninstall --cask
  # removes the .app and leaves user data (agents, SQLite DB,
  # wiki, workspaces, logs) in place so a subsequent
  # brew install --cask openagentd is a true upgrade, not
  # a fresh start. Users who want a full wipe should remove
  # ~/.config/openagentd, ~/.local/share/openagentd*,
  # ~/.local/state/openagentd and ~/.cache/openagentd
  # manually — see documents/docs/configuration/paths.md.

  caveats <<~EOS
    Apple Silicon only. Intel Mac users: install the CLI with
    "brew install openagentd" instead.

    Uninstall keeps your data. brew uninstall --cask
    openagentd removes the app only; agents, sessions, and
    wiki under ~/.config/openagentd and ~/.local/share/openagentd*
    are preserved.
  EOS
end
