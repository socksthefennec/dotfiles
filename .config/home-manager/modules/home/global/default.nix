{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkDefault mkOption;
  cfg = config.sockscfg;
in {
  options.sockscfg = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable Socks' config.
      '';
    };
    graphics = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable graphical programs (e.g. firefox, neovide).
        '';
      };
    };
  };

  config = {
    sockscfg.neovim.enable = mkDefault cfg.enable;
    programs.home-manager.enable = mkDefault true;
    home = {
      username = mkDefault "socks";
      homeDirectory = mkDefault "/home/${config.home.username}";
      packages = with pkgs; mkDefault [git];
      extraOutputsToInstall = mkDefault ["man" "info" "devdoc"];
      language.base = mkDefault "en_AU.UTF-8";
    };
    manual.html.enable = mkDefault true;
  };
}
