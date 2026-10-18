class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.15.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.15.0/openagentd-3.15.0-aarch64-apple-darwin.tar.gz"
    sha256 "1b1887ab174e67e3ebc0857034efb48b8ff538800ed31cfbb06873ef3870c46a"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.15.0/openagentd-3.15.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bb30ec4cf74503b70da430a65a856ac80c3f6045374d9339323c0ef57f7b534b"
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
