class Openagentd < Formula
  desc "Local coding agent server and CLI"
  homepage "https://openagentd.dev"
  version "3.16.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.16.0/openagentd-3.16.0-aarch64-apple-darwin.tar.gz"
    sha256 "5bae2811385529456c6303734ecd82a1b01e01e89c1410d733da0cc75f2d61a1"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/lthoangg/openagentd/releases/download/v3.16.0/openagentd-3.16.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c65fd24e7e2c021be42f4c508ee2344fd48f235e2ff1b6a717defaf73fcc9872"
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
