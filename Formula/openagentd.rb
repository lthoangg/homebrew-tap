class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.45.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.45.0/openagentd-3.45.0-aarch64-apple-darwin.tar.gz"
    sha256 "90ac88507981ade9c1fa0ce761b34a29534dac8d7cf39a2f3e31e1b4dde30863"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.45.0/openagentd-3.45.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0c8ec5017c663ca517e8833204c78a672df551e844d07a3eb8b3bca331edee10"
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
