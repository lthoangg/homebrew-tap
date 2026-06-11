class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/8f/d4/16cb0554a679638a4a397a1139c45df626ef46d26afc139c6af3d832cd0c/openagentd-1.51.2.tar.gz"
  sha256 "3bb93eb323d093a73c8c988b203ea292297a01f5cd80e07a93397728c06bce2e"
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
