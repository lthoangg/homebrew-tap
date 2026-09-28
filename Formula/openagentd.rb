class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.0.0/openagentd-3.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "fba4555742293985c92f07e1006358cfabf69558fbb2db5998452361b84f34db"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.0.0/openagentd-3.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "6e81465e37dd7d0521135d78f656d950b30a238600333f5dfde0c82fceda98a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.0.0/openagentd-3.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba827826f8a3a517b9fdf258b89975b6ff1c5930ba16112f0004434e022d1494"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.0.0/openagentd-3.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "41e8ed0ae24ef1aea036f6e7999f3df247b5ebd64dd6aa0d8a90063b723c1739"
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
