{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.main-user;
in {
  options.main-user = {
    enable =
      lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "user";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      description = "main user";
      isNormalUser = true;
      extraGroups = ["wheel" "video" "audio"]; # Enable ‘sudo’ for the user.
      shell = pkgs.zsh;
      packages = with pkgs; [
        floorp
        steam
        obsidian
        nsxiv
        signal-desktop
        gitkraken
        thunderbird
        bitwarden
        bitwarden-cli
        rofi-rbw
        firefox
        prismlauncher
      ];
    };
    nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];

    programs.zsh.enable = true;
    services.getty.autologinUser = "${cfg.userName}";
  };
}
