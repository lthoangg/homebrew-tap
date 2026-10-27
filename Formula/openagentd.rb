class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.33.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.33.0/openagentd-3.33.0-aarch64-apple-darwin.tar.gz"
    sha256 "ff204831c2f95cc4114e6ac434e224d06821d00599a142e03fa4778110e4a43a"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.33.0/openagentd-3.33.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e7b97e40d8eb76ac4c852eb1061fd4722a701aa656bb3a4ea3852aa1bb4f3dac"
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
