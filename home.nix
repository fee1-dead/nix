{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "beef";
  home.homeDirectory = "/home/beef";

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_USE_XINPUT2 = "1";
  };
  home.packages = with pkgs; [
    neovim
    iosevka
    wget
    rnix-lsp
    jetbrains.idea-community
    obs-studio
    kdenlive
    rubberband
    mlt
    rustup
    git-absorb
    python3
    huggle
    vlc
    discord
    betterdiscordctl
    zoom-us
    huggle
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      ms-vscode-remote.remote-ssh
      zhuangtongfa.material-theme
      eamodio.gitlens
      usernamehw.errorlens
      vscodevim.vim
      vadimcn.vscode-lldb
      arrterian.nix-env-selector
      github.copilot
      ms-vscode.cpptools
      formulahendry.code-runner
      WakaTime.vscode-wakatime
      ms-vsliveshare.vsliveshare
    ];
    userSettings = {
      "_comment" = "This should only be edited at ~/.config/nixpkgs/home.nix.";
      "workbench.colorTheme" = "One Dark Pro Darker";
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "'Iosevka'";
      "editor.fontSize" = 20;
      "files.autoSave" = "afterDelay";
      "editor.inlineSuggest.enabled" = true;
      "code-runner.runInTerminal" = true;
      "rust-analyzer.imports.granularity.enforce" = true;
      "rust-analyzer.imports.granularity.group" = "module";
    };
  };

  programs.git = {
    enable = true;
    userName = "Deadbeef";
    userEmail = "ent3rm4n@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
  };

  programs.starship = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
