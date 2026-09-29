class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.1.0/openagentd-3.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "36a4f720ff7e46ed97d3c73f569fb23bbd50ef6b2567824cc6b68cb865f947b2"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.1.0/openagentd-3.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "acf4dc373952905bebf447faa4596defc1040286733d55136dcaf714feecd71e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.1.0/openagentd-3.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d2a1b884f057375897128ff13f0bceef22a76c986aef40610aef82773df9841"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.1.0/openagentd-3.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9a92d45dcc99465af8daf8cdff5b6a7f8cf77cc7756c61dc7681064905c04c03"
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
