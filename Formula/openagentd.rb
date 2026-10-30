class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.38.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.38.0/openagentd-3.38.0-aarch64-apple-darwin.tar.gz"
    sha256 "25b8b4e096de0d9303fb5f4536e9f21bc25b3c9ec29b1fed770d997ecb1d66cb"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.38.0/openagentd-3.38.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f6f51568c859554bb54ad01286bb763a06059fbf6778c758f5a3662d79b7622a"
  end

  def install
    # Every executable at the archive root (agentd, the openagentd
    # alias, plus any future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `agentd --help` to get started, or see
      https://openagentd.dev for setup guides.
      Upgrade with `brew upgrade openagentd` (`agentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "agentd v#{version}", shell_output("#{bin}/agentd --version")
  end
end
