class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.2.0"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.0/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "14d496e85debf54db9474b09c4e107b1c9d2a6f81e9233710d6166faab27fe71"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.0/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24e58af73508105a787a22c057c89dd3be3afe2c3459f7a9d19bf75170be1124"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.0/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "18f1debaf0cba585cf563414d6a88603d0fa40abfd319c9314ec2a1817785601"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.0/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cf1cbcf6360d63a5b601d191932dd17e00f0a0ca1925e7941f21fb8ec5aa279c"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
