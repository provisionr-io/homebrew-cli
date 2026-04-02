class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/RELEASE_TAG/mac-arm"
      sha256 "SHA256_MAC_ARM"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/RELEASE_TAG/mac-x64"
      sha256 "SHA256_MAC_X64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/RELEASE_TAG/linux-arm"
      sha256 "SHA256_LINUX_ARM"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/RELEASE_TAG/linux-x64"
      sha256 "SHA256_LINUX_X64"
    end
  end

  def install
    bin.install stable.url.split("/").last => "provisionr-workspace-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "prv-nightly"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace-nightly --version")
  end
end
