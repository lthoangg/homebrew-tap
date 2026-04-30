class Openagentd < Formula
  include Language::Python::Virtualenv

  desc "On-machine multi-agent AI assistant with a web cockpit"
  homepage "https://github.com/lthoangg/openagentd"
  url "https://files.pythonhosted.org/packages/source/o/openagentd/openagentd-0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "Apache-2.0"
  head "https://github.com/lthoangg/openagentd.git", branch: "main"

  bottle do
    rebuild 1
    root_url "https://ghcr.io/v2/lthoangg/tap"
  end

  depends_on "python@3.14"
  depends_on "uv" => :build

  def install
    # Install into an isolated virtualenv managed by Homebrew
    virtualenv_install_with_resources
  end

  def post_install
    # Create XDG config directory so first-run init has a home
    (var/"openagentd").mkpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/openagentd --version")
  end
end
