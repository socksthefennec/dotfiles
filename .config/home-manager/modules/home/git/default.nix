{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkIf mkDefault mkOption;
  cfg = config.sockscfg.git;
in {
  options.sockscfg.git = {
    enable = mkOption {
      type = types.bool;
      default = config.sockscfg.enable;
      description = ''
        Whether to enable git.
      '';
    };
  };

  config.programs.git = mkIf cfg.enable {
    enable = true;
    userName = mkDefault "Socks Candy";
    userEmail = mkDefault "socksthefennec@gmail.com";
    signing = {
      key = mkDefault "B74F16D7F971CE9E840F815BCE83F5E5DDD46B29";
      signByDefault = mkDefault true;
    };
    lfs.enable = true;
    extraConfig = {
      init = {defaultBranch = mkDefault "main";};
    };
  };
}
