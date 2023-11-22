{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkDefault mkOption;
  cfg = config.sockscfg.ssh;
in {
  options.sockscfg.ssh = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable Socks' config.
      '';
    };
  };

  config = {};
}
