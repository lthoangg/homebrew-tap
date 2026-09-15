class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/f8/af/b3d36418906fd94fe3472437d6afba404d946a016198c2517ae06d48eb9f/openagentd-2.18.0.tar.gz"
  sha256 "0dd47e9c8f70a2b485e6bde3bd004eaf7ce7358ecd35b874fb78417749eeb668"
  license "Apache-2.0"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "--upgrade", "pip"
    # Install from prebuilt wheels (including cryptography) so no Rust
    # toolchain is required on the user's machine. Homebrew may emit a
    # cosmetic "Failed changing dylib ID" warning for cryptography,
    # which is harmless and does not affect functionality.
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/openagentd"
  end

  def caveats
    <<~EOS
      Run  to get started, or see
      https://github.com/lthoangg/OpenAgentd for documentation.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
