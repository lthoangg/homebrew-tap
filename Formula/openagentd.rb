class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.23.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.23.0/openagentd-3.23.0-aarch64-apple-darwin.tar.gz"
    sha256 "68f09f65667d4c876e5d4135ddc4bcc016038c849044e6117835111a55e94f91"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.23.0/openagentd-3.23.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f4cb13d7edfa92dc6c0f40c4c38cc1c14964a39eef497c5a60b58c022ac90b5f"
  end

  def install
    # Every executable at the archive root (agentd, the openagentd
    # alias, plus any future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `agentd --help` to get started, or see
      https://openagentd.dev for setup guides.
      Upgrade with `brew upgrade openagentd` (`agentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "agentd v#{version}", shell_output("#{bin}/agentd --version")
  end
end
