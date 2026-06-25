class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/63/85/723bd1ffccb10f384b3e9c4f1628fca8600f2455af41dd0c58bc35147bf7/openagentd-1.64.0.tar.gz"
  sha256 "d606e85b3eeeaf91fe885265c1d430945cd66b490828a5bb6c076c4ae5ff0e9f"
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
