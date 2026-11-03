class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.41.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.41.0/openagentd-3.41.0-aarch64-apple-darwin.tar.gz"
    sha256 "6d36aaaca30d0a25dce174a1dfb1337c4105e5f0ded4b1c09e020e09db5b6fdf"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.41.0/openagentd-3.41.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "096ee2f596bf75b3a43dcc1ebef478427b324a3637da59ed44a62571f48277e3"
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
