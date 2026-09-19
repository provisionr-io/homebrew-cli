class ProvisionrWorkspace < Formula
  desc "Provisionr Identity Platform Workspace CLI"
  homepage "https://provisionr.io"
  version "26.09.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1/mac-arm"
      sha256 "df2b25f732d53c65f9c29fc9ccf6ab6b0b705e069a3a2bc870192845d95632e4"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1/mac-x64"
      sha256 "9d0269a46d6bc4c79dacf78d8a430ffca88240e3e2fd5bede71136b02830d932"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1/linux-arm"
      sha256 "69e0e284e1ab544e5a71a0aa746384179c9b981ba996849da35815f1356ef2ae"
    end

    on_intel do
      url "https://github.com/provisionr-io/homebrew-cli/releases/download/provisionr-workspace-26.09.1/linux-x64"
      sha256 "8ef16987a4ef78d57a1349826c964fa0ba452ac6e2729d8c8eb37c72e760e073"
    end
  end

  def install
    downloaded = stable.url.split("/").last
    chmod 0755, downloaded
    bin.install downloaded => "provisionr-workspace"
    bin.install_symlink "provisionr-workspace" => "provisionr"
    bin.install_symlink "provisionr-workspace" => "prv"

    generate_completions_from_executable(bin/"provisionr-workspace", "completion")

    (zsh_completion/"_provisionr").write "#compdef provisionr\n(( $+functions[_sf_provisionr-workspace] )) || source #{zsh_completion}/_provisionr-workspace\ncompdef _sf_provisionr-workspace provisionr\n"
    (zsh_completion/"_prv").write "#compdef prv\n(( $+functions[_sf_provisionr-workspace] )) || source #{zsh_completion}/_provisionr-workspace\ncompdef _sf_provisionr-workspace prv\n"
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

      If you use oh-my-zsh, add the FPATH line before "source $ZSH/oh-my-zsh.sh"
      (oh-my-zsh calls compinit for you, so only the FPATH line is needed).

      For bash, add the following to your ~/.bash_profile:
        [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/provisionr-workspace --version")
  end
end
