class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.20.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.20.0/openagentd-3.20.0-aarch64-apple-darwin.tar.gz"
    sha256 "b63079ed31536dab319013bebbac95d21bd32e19ee3587ce02bc20eb02f36bfd"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.20.0/openagentd-3.20.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a152ed1426df3b9352f380c07ed8b23edb48823de7d9af6c7325722e756df465"
  end

  def install
    # Every executable at the archive root (agentd, the openagentd
    # alias, plus any future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `agentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`agentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "agentd v#{version}", shell_output("#{bin}/agentd --version")
  end
end
