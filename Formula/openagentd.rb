class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.54.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.54.0/openagentd-3.54.0-aarch64-apple-darwin.tar.gz"
    sha256 "cf03bd52e07ec9ea7e40783335e0668054fd4b9c577ee6154e280c5c4ef1fc38"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.54.0/openagentd-3.54.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "071394c0b173d91e0ed67cebc13376e90a1c61cb6d403bdde2b4e18b123ba5af"
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
