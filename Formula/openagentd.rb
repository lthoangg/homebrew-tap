class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.25.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.25.1/openagentd-3.25.1-aarch64-apple-darwin.tar.gz"
    sha256 "aea283e79b343f25b27dae4d12cc538f63e18e8c7e20a877651b9c0526c2f4e8"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.25.1/openagentd-3.25.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c1b2951c278574b60fad8ce54c4889a0335183b8cf53ef4ac17dbd74ecc5209e"
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
