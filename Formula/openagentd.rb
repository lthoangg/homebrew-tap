class Openagentd < Formula
  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/source/o/openagentd/openagentd-0.3.3.tar.gz"
  sha256 "62272b048ce093a039211e4f170e4ec8023e4bda1d9b9a773c9b418f0c32c145"
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

  def caveats
    <<~EOS
      This formula installs the base package only. Optional extras are not
      supported by Homebrew. To enable voice input (local Whisper transcription):

        uv tool install "openagentd[voice-local]"
        # or
        pip install "openagentd[voice-local]"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
