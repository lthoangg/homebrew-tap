class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.51.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.0/openagentd-3.51.0-aarch64-apple-darwin.tar.gz"
    sha256 "33984b269e36bb91c79dd1cfaeba48ff8465479d44d40ea70ee00ca9c63699b3"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.51.0/openagentd-3.51.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e4863fe8191efe2f4f003ad3b549b9a23426601da5b4127a39c24c896a14846e"
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
