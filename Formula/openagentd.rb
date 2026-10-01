class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  version "3.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.4.0/openagentd-3.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "b6b696ecd71475bd691a844e13be5c57a83fb9b277ec6181ee943c815c64cf61"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.4.0/openagentd-3.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "afb476551e175149d1f7f5ca8348f2e0b096da2cda1ec5e8be019ec2dbeed761"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.4.0/openagentd-3.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25d5239495aa9bd8e386a9413c5eb2e6c829a7cb7d555753aeade3072c321fff"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.4.0/openagentd-3.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f623dd23629295fd34f86f1c2983c985b5ee33dba1e88bb72dc3550535d40f92"
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
