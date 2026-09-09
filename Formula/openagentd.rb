class Openagentd < Formula
  desc "On-machine AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/c4/c4/1e3c3a839c25638281acfc7f3c10f70b53813babe0b324328df4690be726/openagentd-2.13.0.tar.gz"
  sha256 "93b4c1aabce503eff715cefed3b93bf9aba406da7b986e2176e8464497e22bec"
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
