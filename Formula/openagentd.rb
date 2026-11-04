class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.44.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.44.0/openagentd-3.44.0-aarch64-apple-darwin.tar.gz"
    sha256 "fcc1fdc869c306a9d1ae747c4d26d4ed331ee63bb8cab853ebcdba39a291347e"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.44.0/openagentd-3.44.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "00625b31b1ed96eaaeb250424739768c93577e7274b7fb1adb306727e97e6e04"
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
