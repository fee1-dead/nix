{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "beef";
  home.homeDirectory = "/home/beef";

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
  home.packages = [
    pkgs.neovim
  #	pkgs.vscode
    pkgs.iosevka
    pkgs.wget
    pkgs.rnix-lsp
    pkgs.jetbrains.idea-community
    pkgs.obs-studio
    pkgs.kdenlive
    pkgs.rubberband
    pkgs.mlt
    pkgs.rustup
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      ms-vscode-remote.remote-ssh
      zhuangtongfa.material-theme
#      tonybaloney.vscode-pets
    ];
  };
  programs.git = {
    enable = true;
    userName = "Deadbeef";
    userEmail = "ent3rm4n@gmail.com";
  };
}
