class ProvisionrWorkspaceNightly < Formula
  desc "Provisionr Identity Platform Workspace CLI (nightly)"
  homepage "https://provisionr.io"
  version "26.09.1-rc1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1-rc1/mac-arm"
      sha256 "604e0cedb8b478db9ae45d2a022b5bb2629bfead7cad82a9da394515d29274b3"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1-rc1/mac-x64"
      sha256 "836e7d70959189c6ab5fa0a83bdab2b0774d81052b9099d26ba03deb7aa862d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1-rc1/linux-arm"
      sha256 "ec950d8c1e080a43b94afb0fd97997d78397b70a7b3a1317e4d9a9a55c85ef06"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1-rc1/linux-x64"
      sha256 "a76b8e842e831a9670268704add1d5f5d1bc7d8b96abff55c8d159838e9e0e0d"
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
