class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.09.2-rc2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.2-rc2/mac-arm"
      sha256 "83b1c2530b7fe55e78e382b4d6250ba0b8f1ef467dd766fb9bad237d18444a38"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.2-rc2/mac-x64"
      sha256 "fa9394acce8e3539dc3a45dd02372f4c04f2a56fad863d221764cdf9a9fa908a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.2-rc2/linux-arm"
      sha256 "75ede6d52532c10dfac5fbf4403f20f6fc9ce2fe91e53364b2a57288bb1037dd"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.2-rc2/linux-x64"
      sha256 "a6a3d0bc475a19896a52b18d0cc63326cf2fa71365328c0a9846bc507960e0b0"
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
