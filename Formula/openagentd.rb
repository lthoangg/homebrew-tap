class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.32.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.32.0/openagentd-3.32.0-aarch64-apple-darwin.tar.gz"
    sha256 "95a6041f4bd8b7a456f28017b64e9724fe3b6039d73bbbf031d7f308e780c0ca"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.32.0/openagentd-3.32.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1f95885f284fb6bf9caed5acc46787f1e1233e58e36ec1af5eba6bb27e00d3a4"
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
