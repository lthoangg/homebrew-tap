class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.61.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.61.0/openagentd-3.61.0-aarch64-apple-darwin.tar.gz"
    sha256 "8857f808314d5ed127f26ae52aa929b30949c3dacdf78aed3c8493e75a43263c"
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.61.0/openagentd-3.61.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "528de99ccc304198a0f4dfed159d62dd00ce669a66190a3c5497ee396d74755c"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.61.0/openagentd-3.61.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17c1aa3cb867e6695cb099245266b3179e37584dd696f528283b7736616db786"
    end
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
