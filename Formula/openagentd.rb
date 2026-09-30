class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.0/openagentd-3.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "97987e81cbbff9951eb2b1a902ad900982683fefd7d0702f45856c6d0bb21096"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.0/openagentd-3.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "ea8e7583251e77ee31628e582fc6d7c122d148fcf540cc0a34bc94331655e5f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.0/openagentd-3.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff835aec5b5d6d4bd38b0a88cc4d8c91db995153a260a0fb4d954262d0e19330"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.0/openagentd-3.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1158871d748ac32a3f5937657ecd0897e3b552490e6db884281587291adf8753"
    end
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
