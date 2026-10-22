class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.25.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.25.0/openagentd-3.25.0-aarch64-apple-darwin.tar.gz"
    sha256 "4ee846cdf4a9926ac4bfc498fc2c8eca7d9f8df474d00d4cd99d7a6346316c99"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.25.0/openagentd-3.25.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "264f2feae458d59c03e278e830795aab3323a61cc5dd7aeab75a8bacc28c4449"
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
