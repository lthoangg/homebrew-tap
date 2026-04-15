class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.1"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "c75a967581b9ebf0a34e4d7294bf3e579a6e29cf0ae346f63f8e747aec4e63cd"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a69b12ac587b2c41e6d8238acf5c603a0bee24cb385aeb1a1beeab1fead3ad35"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "958316b3116a6d466fdfc7db99a0c0259b8623e6f86cfa6c75ec1e715aa99210"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "705be1d35e6aced02be326cc96d73b2a91d9f6d24868cea90e5b41f99635e7be"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
