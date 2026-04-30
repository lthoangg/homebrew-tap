class Openagentd < Formula
  include Language::Python::Virtualenv

  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/source/o/openagentd/openagentd-0.1.0.tar.gz"
  sha256 "0c242ce01d7672bc783a2cc4df1f8d15979b469f47069fbf86ba872b8118133a"
  license "Apache-2.0"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/openagentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end