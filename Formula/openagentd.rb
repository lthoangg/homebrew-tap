class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.37.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.37.0/openagentd-3.37.0-aarch64-apple-darwin.tar.gz"
    sha256 "6472361f4ccd8ff8972a05286c82ae35e0c7035f7c82686a1aeea94faa3ea91c"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.37.0/openagentd-3.37.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "23b9051d4276611b8a7e9977446fd19040cd72eba610a030babfa2dbc7897f73"
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
