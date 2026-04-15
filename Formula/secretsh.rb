class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.5"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.5/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "a2c6902162ac52d52aaa50bf1d33cdb43b8b3364aa65c16446481e7f72553e63"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.5/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e7ebe9e94a2968b1fe72b49fb6e371edb5c0ddec5b5b9b95fec66b33e58f65a9"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.5/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "dfee4a7d23fef86a1831f5aa708362f132f41f02c4b5831589999d26fddcdbc9"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.5/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b0823158794a914649f89c4414eb79a834559198d31f4eaac3e0786a1fba055"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
