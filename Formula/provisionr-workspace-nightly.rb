class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc13"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc13/mac-arm"
      sha256 "26c8603aa07c16b72d7122ebfcf60e603dbdb6e3ffcab16e4d644882cdb87225"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc13/mac-x64"
      sha256 "b0019c8bc3d797e89815dafa4670cf40c00e538160f2ff8cf7ee2d9f2c0b221c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc13/linux-arm"
      sha256 "352dfc033ba512383ab5cb841b36c168990e948024505cab5704850fc0ca843b"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc13/linux-x64"
      sha256 "3e5bf5d7c92676bcde03360035f51fd8654721aaa3074ca0bfff0d2d95afeb79"
    end
  end

  def install
    bin.install stable.url.split("/").last => "provisionr-workspace-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "prv-nightly"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace-nightly --version")
  end
end
