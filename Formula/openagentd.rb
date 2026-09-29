class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.2.0/openagentd-3.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "5cb96629793c9459837a5d2dddfd0ce6dfda82571a0caf56308002ed0fd2e568"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.2.0/openagentd-3.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "d38be8f531865dbedfe9d5129f7291ccded27441cba9c02578b1e4b92e2a96a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.2.0/openagentd-3.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f5c4c21089db3a76207ce8590652adda8ef7b94c3d41a3320f13c34f249aa8fb"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.2.0/openagentd-3.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c1d82d7f7fce72e097cd7e0b7caca5c172b7a73be0e6810e96375871b7076945"
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
