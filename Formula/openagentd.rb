class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.3.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.1/openagentd-3.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "0cff5cd4d7d1a950a24ba7d2833e3488f8180f9851d4bd48a2cd0f180a7086dc"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.1/openagentd-3.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "42ac93ba058bc38ca0e363abfa7b2329c1793745c064c7fee3fb65d2de61f56b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.1/openagentd-3.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8eb1a12726eac036e83812b8c50e0cc872f56551279171fa20366b44e20deea2"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.3.1/openagentd-3.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65dff39e7857d3182b3f160a047b6bb6d5516f16d0374afe2e52afc9a2ee1edc"
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
