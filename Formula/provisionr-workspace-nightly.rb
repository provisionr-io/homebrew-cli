class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc16"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc16/mac-arm"
      sha256 "237c3406f850d6385f4dc2c3ca9f0d3a5f97f24f1f7424450b677c5e98e72102"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc16/mac-x64"
      sha256 "3d471681a7f071daeb6c4d590c6575d5a8ec7ba941c0fa6f43e01fe764f6829d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc16/linux-arm"
      sha256 "1dd2157361db8fe7452d93a8a3c79b47ae9998a6423cca865fd0d1f0d5470790"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc16/linux-x64"
      sha256 "3002c71c7128b14ea0f2e53bed3114188737f884fbb39d57eed406d4444e4b8b"
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
