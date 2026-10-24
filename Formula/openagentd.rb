class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.29.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.29.0/openagentd-3.29.0-aarch64-apple-darwin.tar.gz"
    sha256 "745bb1ffdcf164e1f12c3a7946d3a37769c7bc072dda051a0b9a6ae2297b7fad"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.29.0/openagentd-3.29.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f3437ee7d63ec1285ce936ac8f565a7306d9b25e2a4a4098a1064452ffc5d36f"
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
