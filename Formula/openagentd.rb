class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.51.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.1/openagentd-3.51.1-aarch64-apple-darwin.tar.gz"
    sha256 "b7ad34c39f418e7d6fc5a8aa996dffdeb8ca47d6c17c7c66a2a302d4e67b01fa"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.1/openagentd-3.51.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a26c15f2089a58b48c0f8b00d5b522c68d1a52bd591819f1f2ca53eff2e971f8"
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
