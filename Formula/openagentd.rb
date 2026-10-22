class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.26.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.26.0/openagentd-3.26.0-aarch64-apple-darwin.tar.gz"
    sha256 "05b11990630de76fc17952a4cc0d204c5e61d20f09c4d0f58a341f2d70546f81"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.26.0/openagentd-3.26.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fc4ffb34cabc58514daf7412ec65da94e0a1fdee3eb475a4ffb3233cf360af48"
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
