class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.43.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.43.0/openagentd-3.43.0-aarch64-apple-darwin.tar.gz"
    sha256 "7751c50ee554dd7a49e66a4f304a06e513615c0792171f00a181bbd2115fbebc"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.43.0/openagentd-3.43.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "669b6b88d17032b0973f447eaa20c97a8d1bdeb9c00dd212ba6dc7fb05689ec3"
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
