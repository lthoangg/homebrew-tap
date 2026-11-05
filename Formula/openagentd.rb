class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.46.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.46.0/openagentd-3.46.0-aarch64-apple-darwin.tar.gz"
    sha256 "3379ffc6b738ddc1fa5d4013c4bd1cbbd6e12d46ab08622de93bf5cecb2eda53"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.46.0/openagentd-3.46.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0d5a5985ae5c48466ce1755a34bcbfae24f57c2402ac8a1111a6781b781ea125"
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
