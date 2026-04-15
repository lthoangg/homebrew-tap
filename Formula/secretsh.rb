class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.1"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "455a94d87262ab331a82304064b9e7ff2b016df4d2e3ac3c7fadd798a5f5c3f8"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "570e2b7fb1e1e7d11317b03205ff0ffc0b1d24f6a2c41be945c04b565de708aa"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "c19098b085bb628b3a8a406d574e2e63f75b2cf5482c2949ea960e87b147c41b"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.1/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98411d376a25bf9cc6b2e91535870b5f025b5ae5365ecce3ce50143b3a51f1de"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
