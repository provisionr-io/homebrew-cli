class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.04.0-rc17"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc17/mac-arm"
      sha256 "13b7d6ef536282e27fb8ea390e9f779e329527f0939dfb9db2347bfb32cfb1f8"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc17/mac-x64"
      sha256 "308b886b0af06c0d44f3c4833cbd6caa070e580fe76e5f295f32c5fe393f1589"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc17/linux-arm"
      sha256 "0add826fc4045e64ef12efeeca28245b88eae934d074c95dedb5d68e7d25d506"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.04.0-rc17/linux-x64"
      sha256 "b769021bb57e277e24c7ade14326d660a6bcb490e590aa293af38f9ce08aa7cf"
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
