class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.19.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.19.0/openagentd-3.19.0-aarch64-apple-darwin.tar.gz"
    sha256 "fc9deb946d49100627bc18ea340e5b79a88e474fbd1d271c1e138190ba8cf600"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.19.0/openagentd-3.19.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "235691b22ac137426f80a8af5fe8627e03cb2f4ce27c2ffef46cb0071061eb69"
  end

  def install
    # Every executable at the archive root (agentd, the openagentd
    # alias, plus any future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `agentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`agentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "agentd v#{version}", shell_output("#{bin}/agentd --version")
  end
end
