{ config, pkgs, ... }:
let
  userName = "user";
in
{
  imports = [
    <home-manager/nixos>
  ];

  users.users."${userName}" = {
    isNormalUser = true;
    hashedPassword = "$6$Rj2KVboc.eXZp7eU$4CmgybO/Gl54ANPi3rciQLXzSNUMiNlxdrOfqEGDhpgKSDe9TOIWwybHXIUyIadtnal4c5aSMN54LelpzTGrk1";
    extraGroups = [
      "wheel"
      "video"
    ];
  };

  home-manager.users."${userName}" = {
    home.stateVersion = config.system.stateVersion;

    imports = [
      ../home/desktop
    ];

    home.packages = with pkgs; [
      firefox-wayland
      lftp
      ncmpcpp
      ncpamixer
      pavucontrol
      rink
      xdg-utils
      yt-dlp
    ];
  };
}
