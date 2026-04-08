class ProvisionrWorkspace < Formula
  desc "Provisionr Identity Platform Workspace CLI"
  homepage "https://provisionr.io"
  version "26.04.0"
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
    downloaded = stable.url.split("/").last
    chmod 0755, downloaded
    bin.install downloaded => "provisionr-workspace"
    bin.install_symlink "provisionr-workspace" => "provisionr"
    bin.install_symlink "provisionr-workspace" => "prv"

    generate_completions_from_executable(bin/"provisionr-workspace", "completion")

    zsh_completion.install_symlink "_provisionr-workspace" => "_provisionr"
    zsh_completion.install_symlink "_provisionr-workspace" => "_prv"
    bash_completion.install_symlink "provisionr-workspace" => "provisionr"
    bash_completion.install_symlink "provisionr-workspace" => "prv"
    fish_completion.install_symlink "provisionr-workspace.fish" => "provisionr.fish"
    fish_completion.install_symlink "provisionr-workspace.fish" => "prv.fish"
  end

  def caveats
    <<~EOS
      To enable shell completions, make sure your shell is configured to load Homebrew completions.

      For zsh, add the following to your ~/.zshrc (before compinit):
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit
        compinit

      For bash, add the following to your ~/.bash_profile:
        [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace --version")
  end
end
