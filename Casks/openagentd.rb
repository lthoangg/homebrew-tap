cask "openagentd" do
  version "3.39.0"
  sha256 "7abcea2510052a21947d1f6dee9c1a644ae878ed95be15aab4d6fdbc9abc94b4"

  url "https://github.com/lthoangg/openagentd/releases/download/v3.39.0/OpenAgentd_3.39.0_aarch64.dmg"
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

  # CI signs the app ad hoc (no paid Apple Developer ID). A
  # downloaded copy carries the quarantine flag, and macOS
  # rejects it with the "OpenAgentd.app" is damaged error,
  # so strip the flag, as desktop/scripts/install.sh does.
  # Do not re-sign: the app keeps CI's signature, the same one
  # the in-app updater installs.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OpenAgentd.app"],
                   must_succeed: false
  end

  # Intentionally no zap block. brew uninstall --cask
  # removes the .app and leaves user data (agents, SQLite DB,
  # wiki, workspaces, logs) in place so a subsequent
  # brew install --cask openagentd is a true upgrade, not
  # a fresh start. Users who want a full wipe should remove
  # ~/.config/openagentd, ~/.local/share/openagentd*,
  # ~/.local/state/openagentd and ~/.cache/openagentd
  # manually — see documents/docs/configuration/paths.md.

  caveats <<~EOS
    OpenAgentd is not signed with a paid Apple Developer ID.
    The cask removes the download quarantine flag on install,
    so Gatekeeper should accept it. If macOS still complains,
    right-click the app in Finder and choose "Open" once.

    Apple Silicon only. Intel Mac users: install the CLI with
    "brew install openagentd" instead.

    Uninstall keeps your data. brew uninstall --cask
    openagentd removes the app only; agents, sessions, and
    wiki under ~/.config/openagentd and ~/.local/share/openagentd*
    are preserved.
  EOS
end
