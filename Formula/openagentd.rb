class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/6e/03/c30b232ca9bd9c709c5e6a6e6d341baabc61c0b5bd1a1993480821fd6bcd/openagentd-2.3.0.tar.gz"
  sha256 "4bca9a972cd33bd89ed3180346f89fec69ef56c873885250bb8d5d36f0cd273a"
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
