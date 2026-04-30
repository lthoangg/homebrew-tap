class Openagentd < Formula
  include Language::Python::Virtualenv

  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/source/o/openagentd/openagentd-0.1.2.tar.gz"
  sha256 "1ea468a169748fe59e3136b4d6effcd5c4a314513251a9c2a406b63a30b228bb"
  license "Apache-2.0"

  depends_on "python@3.14"

  def install
    python = Formula["python@3.14"].opt_bin/"python3.14"
    venv = virtualenv_create(libexec, python)
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/openagentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
