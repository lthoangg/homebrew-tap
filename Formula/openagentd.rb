class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/source/o/openagentd/openagentd-0.1.7.tar.gz"
  sha256 "e41d767f22b031fa7021082f8dea1a58dc665f6b8ea379f51991fcc6794ffa2b"
  license "Apache-2.0"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "--upgrade", "pip"
    # Build cryptography from source so Mach-O headers have enough
    # padding for Homebrew's dylib relinking (avoids -headerpad error).
    system libexec/"bin/pip", "install", "--no-cache-dir", "--no-binary", "cryptography", "cryptography"
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/openagentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
