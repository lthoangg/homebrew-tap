class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.4"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.4/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "66141149ddc13e8f9739dcb3d9f686aa9f66536bf4c65826f6465e8e60f13474"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.4/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "080ef2a5385bb66c5d03855ae2e7e9658f4851b23c8eed30586eaeaff2dde62b"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.4/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "1eb2d9f2a93a07227cedfeccb1eea78bce6749e9eed8be87a12488dbeb017fb5"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.4/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d35ee9768f160f221b6fc3692b2dab8afee761680fc3d83d5dfec694db992e87"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
