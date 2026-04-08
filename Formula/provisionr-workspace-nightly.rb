class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc19"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc19/mac-arm"
      sha256 "e5b04236472081981cbde8e3d70737ccb62197f100f7f149b5094d6f6f0ad935"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc19/mac-x64"
      sha256 "53cf1040855dbaf24a87c83cd8fca1149ec2f6b2244c819d36981a097a9e33ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc19/linux-arm"
      sha256 "822567ce32a35c6990fe81c4cf97b66448f21fed3c010efb09a47d3ef0848006"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc19/linux-x64"
      sha256 "f7e610c68d256f662835ced39ee9ff6fc5ee4c1645fe3ab743e59fc093c4004b"
    end
  end

  def install
    downloaded = stable.url.split("/").last
    chmod 0755, downloaded
    bin.install downloaded => "provisionr-workspace-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "prv-nightly"

    generate_completions_from_executable(bin/"provisionr-workspace-nightly", "completion", shell_parameter_format: :arg)

    zsh_completion.install_symlink "_provisionr-workspace-nightly" => "_provisionr-nightly"
    zsh_completion.install_symlink "_provisionr-workspace-nightly" => "_prv-nightly"
    bash_completion.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bash_completion.install_symlink "provisionr-workspace-nightly" => "prv-nightly"
    fish_completion.install_symlink "provisionr-workspace-nightly.fish" => "provisionr-nightly.fish"
    fish_completion.install_symlink "provisionr-workspace-nightly.fish" => "prv-nightly.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace-nightly --version")
  end
end
