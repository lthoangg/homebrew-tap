class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.35.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.35.0/openagentd-3.35.0-aarch64-apple-darwin.tar.gz"
    sha256 "3e39d1e6eca0803f688ad3dfee522975b11369215032e643aebde1cafdb640d0"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.35.0/openagentd-3.35.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "13c2cf0e513d6d16436dc2677e5867955dc515cb446fecc6f1b209eb022f4224"
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
