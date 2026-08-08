class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.08.0-rc8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc8/mac-arm"
      sha256 "0c35425776e73fd81d140d85a03de3d4616f6568fc34e7734f38a7ef54556ef8"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc8/mac-x64"
      sha256 "c0c0fea4ee7e30b4c96fb601a3fb1d857f4aaf697918e8d5d252d9800b7180fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc8/linux-arm"
      sha256 "7c7c0425efdd648ff8f814f02621a850e42a12e1dff7419b65b7472741ffcdf8"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.08.0-rc8/linux-x64"
      sha256 "dd6a68141641ede809451603b2a4de5101965487134431dc21b7259c50773c09"
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
