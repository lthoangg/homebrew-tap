class Secretsh < Formula
  desc "Secure subprocess secret injection for AI agents"
  homepage "https://github.com/lthoangg/secretsh"
  version "0.2.1"
  license "MIT"

  on_arm do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.1/secretsh-aarch64-apple-darwin.tar.gz"
      sha256 "824992ceee00368849fa242c38a36faff985d384fa138d678fd56b808ebace91"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.1/secretsh-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba20452f42c3fd424105644ea43b1b6191df3f4708b1b6577c81f50c71b33c27"
    end
  end

  on_intel do
    if OS.mac?
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.1/secretsh-x86_64-apple-darwin.tar.gz"
      sha256 "02be3b26d1d6fa2ec320037a98a67037f9cecb12280682614602ceb6b7c903b2"
    else
      url "https://github.com/lthoangg/secretsh/releases/download/v0.2.1/secretsh-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fcdb88045bdd3ba1de47dbbb4ddccff59f52a9c50a7c49fd9dacf9b189d13241"
    end
  end

  def install
    bin.install "secretsh"
  end

  test do
    assert_match "secretsh", shell_output("\#{bin}/secretsh --version")
  end
end
