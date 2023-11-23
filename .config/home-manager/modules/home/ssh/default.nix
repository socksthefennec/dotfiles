{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkIf mkDefault mkOption;
  cfg = config.sockscfg.ssh;
in {
  options.sockscfg.ssh = {
    enable = mkOption {
      type = types.bool;
      default = config.sockscfg.enable;
      description = ''
        Whether to enable ssh.
      '';
    };
  };

  config.programs.ssh = mkIf cfg.enable {
    enable = true;
    controlMaster = mkDefault "auto";
    controlPersist = mkDefault "10m";
  };
}
