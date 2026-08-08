class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.08.0-rc6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc6/mac-arm"
      sha256 "f119223e986a94c6376597250ba95f902ebd0c763885c883ef5568dbffd986cd"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc6/mac-x64"
      sha256 "1a13e1bb9549b8810d094ca190501d60a8e63bdd0b2fb3ab37d6b061548eca5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc6/linux-arm"
      sha256 "fc7fa4a0b53fd2c2cbbf095a2d78ad6194af1a11dcb4d461f106bc3b7614981c"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc6/linux-x64"
      sha256 "a43d80e897e0e956c0154251282281d04916e4ff7abec7adc4869bf885220ab8"
    end
  end

  def install
    downloaded = stable.url.split("/").last
    chmod 0755, downloaded
    bin.install downloaded => "provisionr-workspace-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bin.install_symlink "provisionr-workspace-nightly" => "prv-nightly"

    generate_completions_from_executable(bin/"provisionr-workspace-nightly", "completion")

    (zsh_completion/"_provisionr-nightly").write "#compdef provisionr-nightly\n(( $+functions[_sf_provisionr-workspace-nightly] )) || source #{zsh_completion}/_provisionr-workspace-nightly\ncompdef _sf_provisionr-workspace-nightly provisionr-nightly\n"
    (zsh_completion/"_prv-nightly").write "#compdef prv-nightly\n(( $+functions[_sf_provisionr-workspace-nightly] )) || source #{zsh_completion}/_provisionr-workspace-nightly\ncompdef _sf_provisionr-workspace-nightly prv-nightly\n"
    bash_completion.install_symlink "provisionr-workspace-nightly" => "provisionr-nightly"
    bash_completion.install_symlink "provisionr-workspace-nightly" => "prv-nightly"
    fish_completion.install_symlink "provisionr-workspace-nightly.fish" => "provisionr-nightly.fish"
    fish_completion.install_symlink "provisionr-workspace-nightly.fish" => "prv-nightly.fish"
  end

  def caveats
    <<~EOS
      To enable shell completions, make sure your shell is configured to load Homebrew completions.

      For zsh, add the following to your ~/.zshrc (before compinit):
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit
        compinit

      If you use oh-my-zsh, add the FPATH line before "source $ZSH/oh-my-zsh.sh"
      (oh-my-zsh calls compinit for you, so only the FPATH line is needed).

      For bash, add the following to your ~/.bash_profile:
        [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace-nightly --version")
  end
end
