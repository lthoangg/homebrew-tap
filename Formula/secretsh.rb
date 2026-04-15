class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.1.2"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.2/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "5ccde638aecc051e6a75125416fc1d1949a825693b0e630a892c1a9bace8fd1d"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.2/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2f4541db3c1a2dc2c14bfb1770b656f3348d54b3e9220ef7cfee84181c7e1dc9"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.2/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "18d9eeb972f58a7cd4dacbf364af118e2789d719d8b811df493e255d41afb20b"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.1.2/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9fe80de20938797fa84eb24d68de17fa0859ff117ea0b368972b2b5818a1255"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
