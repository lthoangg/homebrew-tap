class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.34.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.34.0/openagentd-3.34.0-aarch64-apple-darwin.tar.gz"
    sha256 "24ab757058d231d69d4aa1c47c2e2852abd8885b9e2b67a5485825aeb8434dcc"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.34.0/openagentd-3.34.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "27b7722757aabc4c6541f8f0efa3a53ca6f90ad06006d990759dd9b133fe4a1b"
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
