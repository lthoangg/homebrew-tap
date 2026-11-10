class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.51.2"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.2/openagentd-3.51.2-aarch64-apple-darwin.tar.gz"
    sha256 "b2e64ff790d4ecfc5b2dd3e50b7ab4f4bfda1f5dce4b75dff82dbaaec4db66bf"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.2/openagentd-3.51.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b1afb8bdb3c707960f93c0d3478bafe0138527387af293ae0caf917405b6093b"
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
