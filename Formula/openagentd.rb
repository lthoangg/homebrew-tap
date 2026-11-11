class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.52.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.52.0/openagentd-3.52.0-aarch64-apple-darwin.tar.gz"
    sha256 "eb1bfcb53466f98816acc05ce4975115a70dd48153bcc4cbbeb356a3bbc6df97"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.52.0/openagentd-3.52.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f7e1c04842e3b45687f51412e20952bc9574d2157cb2101fa24254eda11d8adf"
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
