class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.3"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "d22e5a818983997d8d6c394b77787d5ce2a02215ad4cd6c08b07d0c2dfabf853"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9090ef06bcb52eb7eeb29356133101f529895f363882ba25f2e38ec4113daf12"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "ecd0f9b2f729b35653e2f5b1dab7a43b0e8b1059a0d55b9488677a21d22e4d2b"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.3/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47eee5c86c7e3826da6d672b6adf23e6a104024a5526a51290508ff2429958dd"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
