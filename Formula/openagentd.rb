class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.55.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.55.0/openagentd-3.55.0-aarch64-apple-darwin.tar.gz"
    sha256 "022c9b5198726a0392a6d1728751e65a72e0fbb15f5612a0e8a8d590ae23cad5"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.55.0/openagentd-3.55.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6b077676df303c709de65b36ea4e61d424e25488efa03f4e6586a55f97e961ee"
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
