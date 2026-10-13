class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.10.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.10.0/openagentd-3.10.0-aarch64-apple-darwin.tar.gz"
    sha256 "c5440b25d837ef0f38558b49d3ff80c06dd3a1f9a4ba91f2340b07d604167777"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.10.0/openagentd-3.10.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "73ff8a3d8c696a54094391d3e3ff2fbc001aee8d8789937d397c50aa246d8dfc"
  end

  def install
    # Every executable at the archive root (openagentd, plus any
    # future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `openagentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`openagentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "openagentd v#{version}", shell_output("#{bin}/openagentd --version")
  end
end
