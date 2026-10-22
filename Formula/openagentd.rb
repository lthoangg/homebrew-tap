class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.24.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.24.0/openagentd-3.24.0-aarch64-apple-darwin.tar.gz"
    sha256 "88d940bb6a5726518a43528d2d7b28316905aac573f3809ade053adffb4d9118"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.24.0/openagentd-3.24.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c97157911bd2ceb5a955484f3ae2ce12c0d37bfe04848c10a4e9bc24251c613a"
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
