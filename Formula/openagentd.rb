class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.8.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.8.0/openagentd-3.8.0-aarch64-apple-darwin.tar.gz"
    sha256 "68cad1801fb0ef7f7c6d7008d7976275ff6930fb87b4202029eb0d3a246b3e66"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.8.0/openagentd-3.8.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9f6cc788f81daae53b95fd0f055ad690d558d5aef9fb56ba2b7b1657fda12d3b"
  end

  def install
    # Every executable at the archive root (openagentd, plus any
    # future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `openagentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`openagentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "openagentd v#{version}", shell_output("#{bin}/openagentd --version")
  end
end
