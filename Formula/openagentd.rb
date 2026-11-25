class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.63.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.63.0/openagentd-3.63.0-aarch64-apple-darwin.tar.gz"
    sha256 "f6fbc02ff82b5c2c88b60389c7668e100abe4cf0c32137ce390f5df5574f95f5"
  end

  on_linux do
    on_arm do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.63.0/openagentd-3.63.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78d16dffb2d5e40da67f98a338111e7bfe2dd162e5012f31c314629b22e5281f"
    end
    on_intel do
      url "https://github.com/lthoangg/openagentd/releases/download/v3.63.0/openagentd-3.63.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7d6259feb1efd0af9baf23113906c39f87d6fceac8ef22eb045336a234ddf5b"
    end
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
