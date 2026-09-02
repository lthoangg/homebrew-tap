class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/97/58/772056c5e4e960382512d781a98a395118b1058b7581b97da1e642bfc063/openagentd-2.9.0.tar.gz"
  sha256 "f2fa22ed418d1c2b6ebe44c81d2dd750c9cda68b642a028051782f7791b9979b"
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
