class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.47.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.47.0/openagentd-3.47.0-aarch64-apple-darwin.tar.gz"
    sha256 "fa0ccace7fe8e5b90ef1f644dc00c30fcd341f21b4d02a3f77f1c009ba374c5e"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.47.0/openagentd-3.47.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "29c2fcb9ea4f22131e479b6265a51ebab2dc2f9f328438582d1503ba01ad272c"
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
