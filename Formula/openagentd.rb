class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.53.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.53.0/openagentd-3.53.0-aarch64-apple-darwin.tar.gz"
    sha256 "b98a3eee294acb815a54f75a0069d43a500f17530668e2ce1f6eba959ffbc70a"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.53.0/openagentd-3.53.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5dadf5005845d7c204ea9bea98ccbda9372fdb26f69622d9227023fdf75b0c95"
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
