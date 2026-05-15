cask "openagentd" do
  version "1.0.6"
  sha256 "f3fb04b9508dfd91adcba9399b7a5e23589b7cb05ecf17dc4650d327c4160ef2"

  url "https://github.com/lthoangg/openagentd/releases/download/v1.0.6-desktop/OpenAgentd_1.0.6_aarch64.dmg"
  name "OpenAgentd"
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"

  # Apple Silicon only. release-desktop.yml does not build an
  # Intel .dmg today; Intel Mac users should install the CLI
  # Formula instead (brew install openagentd).
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-desktop$/i)
    strategy :github_latest
  end

  auto_updates true

  app "OpenAgentd.app"

  # The bundle ships unsigned (no paid Apple Developer ID). On
  # first launch macOS would otherwise reject it with the
  # "OpenAgentd.app" is damaged error. We replicate the
  # exact workaround from desktop/scripts/install.sh:
  # strip the quarantine xattr, ad-hoc sign the bundle, done.
  #
  # postflight runs once per brew install --cask /
  # brew upgrade --cask, so the dance happens automatically
  # on every version bump.
  postflight do
    app_path = "#{appdir}/OpenAgentd.app"
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", app_path],
                   must_succeed: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-",
                          "--options", "runtime",
                          "--timestamp=none", app_path],
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
    OpenAgentd is unsigned (no paid Apple Developer ID).
    The cask ad-hoc signs the bundle on install, so Gatekeeper
    should accept it. If macOS still complains, right-click
    the app in Finder and choose "Open" once.

    Apple Silicon only. Intel Mac users: install the CLI with
    "brew install openagentd" instead, and open the cockpit at
    http://localhost:4082.

    Uninstall keeps your data. brew uninstall --cask
    openagentd removes the app only; agents, sessions, and
    wiki under ~/.config/openagentd and ~/.local/share/openagentd*
    are preserved.
  EOS
end
