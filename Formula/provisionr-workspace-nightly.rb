class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc20"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc20/mac-arm"
      sha256 "b88e0400dff015fceb68abecc829a0254fe3ce1957b02bca2fcc4aa951bd2df7"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc20/mac-x64"
      sha256 "99ad6ed853c985919690606105ffcc724d4fc2d7900baedf629a0eb2072d8e43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc20/linux-arm"
      sha256 "fdd5d7f95e052e0f7443e20e3946c7489d539e99fff08b1d37d64cecb7a42324"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc20/linux-x64"
      sha256 "fc288027b8e4c979261f7baca157c11e35666cbe8c1611f6fc42841567ffabba"
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
