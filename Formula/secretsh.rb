class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.3"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "66fdff5352a6e21378911c96306f0d110dee07645f23f72c52f3d15846f3e992"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2f9c3df01d814ba292d5a0054621b5e55f51961c6c207e10f03f5cfbab44864a"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "61066ebfe453901b43204ee355c75e0e9ed90d64b9633009588c4981b64bbe75"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2c593a06916e0da930e77a1137840cddb81377ecc254857eec5b94aeb5f4b361"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
