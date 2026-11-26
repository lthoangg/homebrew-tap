class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.63.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.63.1/openagentd-3.63.1-aarch64-apple-darwin.tar.gz"
    sha256 "ec13623d1cabf5f98876cd6262d8772ab1b6e411f2a82a3283f142b8a0190ad0"
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.63.1/openagentd-3.63.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "644dbadb721aad7ff422d41870832c40576d173db41f2a277ce61fcffb0e2531"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.63.1/openagentd-3.63.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "460603cdaedc27fd2344cd011226b9f3ceaac9248ece4d1700bf04ed95c41bb6"
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
