class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.53.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.53.1/openagentd-3.53.1-aarch64-apple-darwin.tar.gz"
    sha256 "db3e88a1e2edaae0292dba34e16c6d1cd480346e43d534eddc7fe236dce11c61"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.53.1/openagentd-3.53.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f8233182dc3c9daabbe39b555fc8f64804814b48fc3932feb9d679b56ef49a8a"
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
