class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.5.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.5.0/openagentd-3.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "cc65f55a455f01e272105e38b8c7d18549c539fa4c4a9262063d578a25fac432"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.5.0/openagentd-3.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "284e2d5ed15e76db0a56688644e0bb09cbfdbf179042c17eb15646a3970c4d61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.5.0/openagentd-3.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "111d12e5b0777c4471e1b9be8a59ce560772b45cf514ec59b4dd5b4f7368353a"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.5.0/openagentd-3.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8f06dc7e71dd0f01b56dc0835d609c46cfc0396fa28c6381fc48faf959fa40f1"
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
