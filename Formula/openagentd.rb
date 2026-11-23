class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.62.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.62.0/openagentd-3.62.0-aarch64-apple-darwin.tar.gz"
    sha256 "066b3d11136e06acaf711ccaed5e00608e676ef5f1b7b067fa9bf3dd9c31b3a4"
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.62.0/openagentd-3.62.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6949e6e25f05c2d0f27c7af469b3d34d8312c2c2521d590a9581e8cf38123060"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.62.0/openagentd-3.62.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "33e017cbb83037a8a376851d2f384e597a7cc0bc2dfdef722faf75ffdb821652"
    end
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
