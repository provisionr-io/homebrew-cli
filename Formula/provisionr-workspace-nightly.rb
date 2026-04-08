class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc18"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc18/mac-arm"
      sha256 "3449244a9a2a8cae7004c40d0af41687970dd092623b33c91d838eb70447d838"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc18/mac-x64"
      sha256 "15ef9e0280cdc3f32b00cda8e9c07882ce31b7f5f704c6b3988628b89c95b622"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc18/linux-arm"
      sha256 "aa8f2ee00d41f65c351ff808174dfdc300a2b7fdce8a3d28e52dd75a7d98a7c3"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc18/linux-x64"
      sha256 "ea7c2c7c41b8e01988c0ec02e5e3cb039cb0df0f1fb20872e23c18913f798994"
    end
  end

  def install
    downloaded = stable.url.split("/").last
    chmod 0755, downloaded
    bin.install downloaded => "provisionr-workspace-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "prv-nightly"

    generate_completions_from_executable(bin/"provisionr-workspace-nightly", "completion")

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
