class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.18.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.18.0/openagentd-3.18.0-aarch64-apple-darwin.tar.gz"
    sha256 "a79172d6d5da2f530dcefc143880ffccf9b8755763d9a05a3faafc5aa39c8cdb"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.18.0/openagentd-3.18.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9910fcc69f0b21c52d85b497ed5fdf45b8ce6c302f5fb667838ee4a921035ec9"
  end

  def install
    # Every executable at the archive root (agentd, the openagentd
    # alias, plus any future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `agentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`agentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "agentd v#{version}", shell_output("#{bin}/agentd --version")
  end
end
