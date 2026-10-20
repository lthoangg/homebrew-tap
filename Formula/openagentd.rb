class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.22.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.22.0/openagentd-3.22.0-aarch64-apple-darwin.tar.gz"
    sha256 "c63ac8b4f5960f04b47b360085376950d57b77e731f76f57d8d397e426ef0e55"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.22.0/openagentd-3.22.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "25413a1a476006afac1d5bd07f94f5b6dc3aefdeb454be114e3ce0f6d42560cf"
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
