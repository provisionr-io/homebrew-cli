class ProvisionrWorkspaceAtRegular < Formula
  desc "Provisionr Identity Platform Workspace CLI (regular channel)"
  homepage "https://provisionr.io"
  url "https://github.com/provisionr-io/homebrew-cli/releases/download/26.04.0/provisionr-workspace"
  sha256 "replace_on_first_release"
  version "26.04.0"
  license "Apache-2.0"

  depends_on "php"

  conflicts_with "provisionr-workspace@rapid", because: "both install the provisionr-workspace binary"
  conflicts_with "provisionr-workspace@rc", because: "both install the provisionr-workspace binary"
  conflicts_with "provisionr-workspace@stable", because: "both install the provisionr-workspace binary"

  def install
    php_version = Utils.safe_popen_read("php", "-r", "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;").strip
    if Version.new(php_version) < Version.new("8.3")
      odie "provisionr-workspace requires PHP 8.3 or higher (found #{php_version})"
    end
    bin.install "provisionr-workspace"
    bin.install_symlink "provisionr-workspace" => "prv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace --version")
  end
end
