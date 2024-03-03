{ lib, config, pkgs, ... }:

{

  options = {
    hacking-tools.enable
     = lib.mkEnableOption "enable hacking tools";
  };

  config = lib.mkIf config.hacking-tools.enable {
    environment.systemPackages = with pkgs; [
      nmap
      netcat-gnu
    ];
  };

}
