class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.08.0-rc4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc4/mac-arm"
      sha256 "79c7388f5d14774d7036bd616d6ccbd953a07b1b8af7b3922fcbff133408fe7b"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc4/mac-x64"
      sha256 "309bb3d555133dc816e8e3b619603de1c4b199649f8ca27f2c167edab7874840"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc4/linux-arm"
      sha256 "c96f4ad2b49a3e34bc4bfbe80f37c160bb47f2528b379ce8b9b07a3136f840b9"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc4/linux-x64"
      sha256 "0b75470daa5e35490011e8f31eea83fa192bf125a355d12b47c0b9c86cdf3e3d"
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
