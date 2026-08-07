class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/b4/76/1178e77c33f1e8b4ae78718a9e88d20c794f779990525c2d612859d01474/openagentd-1.131.0.tar.gz"
  sha256 "6c3d17481f39e3429ef6b3045029c8527f0d547c33fba0f911c97856488bedc4"
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
      This formula installs the base package only. Optional extras are not
      supported by Homebrew. To install with every optional extra:

        uv tool install "openagentd[full]"
        # or
        pip install "openagentd[full]"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
