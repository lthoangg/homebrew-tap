class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.30.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.30.0/openagentd-3.30.0-aarch64-apple-darwin.tar.gz"
    sha256 "b879980d67e19b9a15a8df453e44b4fc7f8ecdfb4a84c1452db89058b4626ab0"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.30.0/openagentd-3.30.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "867fb5aa67ef375d115ee27994e6287b796be9fec185dce5bcb0ae2bf39bba53"
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
