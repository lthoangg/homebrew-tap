class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.6.0/openagentd-3.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "c37720f6c0ff4d1e1a58b31eb96dcad3a4146576b6126dd164ede702cf04361f"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.6.0/openagentd-3.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "195b46ce1318a01c68544b824e2521e51fdc90aa686b8de881b43263253b3d71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.6.0/openagentd-3.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03db51379e4c84a5d304840e6a878c316a5223d106df0b6511e37e3b5aefb1f4"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.6.0/openagentd-3.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "77b295aaac8eacef5860ff825e637c005bfd2456152289d18d9eaa529a8c8b0b"
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
