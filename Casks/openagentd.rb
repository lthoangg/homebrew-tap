cask "openagentd" do
  version "1.120.1"
  sha256 "2a663b334de6f199ba08efc490073f6161547b0db8dd2de38077d10f65231541"

  url "https://github.com/lthoangg/openagentd/releases/download/v1.120.1/OpenAgentd_1.120.1_aarch64.dmg"
  name "OpenAgentd"
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"

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

  # The bundle ships unsigned (no paid Apple Developer ID). On
  # first launch macOS would otherwise reject it with the
  # "OpenAgentd.app" is damaged error. We replicate the
  # exact workaround from desktop/scripts/install.sh:
  # strip the quarantine xattr, ad-hoc re-sign with the
  # bundled entitlements, done.
  #
  # The --entitlements flag is critical. Tauri's build step
  # signs the bundle with our entitlements.plist embedded — but
  # codesign --force --deep --sign - *without*
  # --entitlements strips them, leaving Hardened Runtime on
  # with no exceptions. That silently breaks WebView↔Rust IPC
  # (startDragging(), toggleMaximize(), etc.), the
  # sidecar spawn, and any feature that touches
  # allow-unsigned-executable-memory,
  # disable-library-validation, network.client/server,
  # or device.audio-input.
  #
  # We ship entitlements.plist into Contents/Resources/
  # via tauri.conf.json resources so this re-sign can pick
  # it up without bundling it separately.
  #
  # postflight runs once per brew install --cask /
  # brew upgrade --cask, so the dance happens automatically
  # on every version bump.
  postflight do
    app_path = "#{appdir}/OpenAgentd.app"
    entitlements = "#{app_path}/Contents/Resources/entitlements.plist"
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", app_path],
                   must_succeed: false

    cert_name = "OpenAgentd Local Signer"
    identities = system_command("/usr/bin/security", args: ["find-identity", "-v", "-p", "codesigning"], must_succeed: false).stdout.to_s
    signing_id = "-"

    if identities.include?(cert_name)
      signing_id = cert_name
    elsif identities.include?("Apple Development:")
      signing_id = identities.lines.find { |l| l.include?("Apple Development:") }&.split('"')&.at(1) || "-"
    else
      require "tmpdir"
      require "fileutils"
      tmp_dir = Dir.mktempdir
      cnf_path = "#{tmp_dir}/cert.cnf"
      key_path = "#{tmp_dir}/oad.key"
      crt_path = "#{tmp_dir}/oad.crt"
      p12_path = "#{tmp_dir}/oad.p12"

      cnf_content = "[req]\ndistinguished_name = req_distinguished_name\nprompt = no\n\n[req_distinguished_name]\nCN = OpenAgentd Local Signer\nO = OpenAgentd Local\n\n[v3_req]\nbasicConstraints = CA:FALSE\nkeyUsage = digitalSignature\nextendedKeyUsage = codeSigning\n"
      File.write(cnf_path, cnf_content)

      req_ok = system_command("/usr/bin/openssl", args: ["req", "-x509", "-newkey", "rsa:2048", "-nodes", "-days", "3650", "-config", cnf_path, "-extensions", "v3_req", "-keyout", key_path, "-out", crt_path], must_succeed: false).success?
      p12_ok = req_ok && system_command("/usr/bin/openssl", args: ["pkcs12", "-export", "-legacy", "-inkey", key_path, "-in", crt_path, "-name", cert_name, "-out", p12_path, "-passout", "pass:oadsecret"], must_succeed: false).success?

      if p12_ok
        keychain = "#{Dir.home}/Library/Keychains/login.keychain-db"
        imp_ok = system_command("/usr/bin/security", args: ["import", p12_path, "-k", keychain, "-P", "oadsecret", "-T", "/usr/bin/codesign"], must_succeed: false).success?
        if imp_ok
          system_command("/usr/bin/security", args: ["add-trusted-cert", "-d", "-r", "trustRoot", "-p", "codeSign", "-k", keychain, crt_path], must_succeed: false)
          signing_id = cert_name
        end
      end
      FileUtils.rm_rf(tmp_dir)
    end

    codesign_args = ["--force", "--deep", "--sign", signing_id, "--options", "runtime"]
    codesign_args += ["-r=designated => identifier \"com.openagentd.desktop\""] if signing_id == "-"
    codesign_args += ["--timestamp=none"] if signing_id == "-"
    codesign_args += ["--entitlements", entitlements] if File.exist?(entitlements)
    codesign_args << app_path
    system_command "/usr/bin/codesign",
                   args: codesign_args,
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
