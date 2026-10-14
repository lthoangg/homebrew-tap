class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.11.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.11.1/openagentd-3.11.1-aarch64-apple-darwin.tar.gz"
    sha256 "86c935da7ed145dda583cc21187834bf9750e9c65b55a3540b85865c30abd88d"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.11.1/openagentd-3.11.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2663d1a02a12390fc8785d5a2fb511114bd21122f485f49b9f19aba30004f644"
  end

  def install
    # Every executable at the archive root (openagentd, plus any
    # future companion binary).
    Dir["*"].each { |f| bin.install f if File.file?(f) && File.executable?(f) }
  end

  def caveats
    <<~EOS
      Run `openagentd --help` to get started, or see
      https://github.com/lthoangg/openagentd for documentation.
      Upgrade with `brew upgrade openagentd` (`openagentd upgrade` does this too).
    EOS
  end

  test do
    assert_match "openagentd v#{version}", shell_output("#{bin}/openagentd --version")
  end
end
