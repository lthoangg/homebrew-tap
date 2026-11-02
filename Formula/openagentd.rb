class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.40.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.40.0/openagentd-3.40.0-aarch64-apple-darwin.tar.gz"
    sha256 "89a26e3fa5e3cf1775becabfc208de5510bce4cc441d38054114ca4130eabf3f"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.40.0/openagentd-3.40.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bf9476cd4a38fad45a6cd4be2aca4846e125bdafd43dc6dfa4515ee6ce3c6cce"
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
