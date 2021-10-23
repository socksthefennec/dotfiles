{ config, pkgs, ... }:

{
  imports = [ ./programs ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "socks";
    homeDirectory = "/home/socks";
    packages = with pkgs; [ git nixfmt ];
    sessionVariables = { EDITOR = "nvim"; };
    extraOutputsToInstall = [ "man" "info" "devdoc" ];
    # language.base = "en_AU.UTF-8";
  };

  # Fix nixpkgs man on non-nixos
  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  programs = {
    fzf = {
      enable = false;
      # enable = true;
      # enableZshIntegration = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
