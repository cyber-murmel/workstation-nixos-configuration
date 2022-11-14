{ pkgs, ...}:

{
  imports = [
    # system
    ./audio.nix
    ./boot.nix
    ./datetime.nix
    ./fonts.nix
    ./fwupd.nix
    ./gpu.nix
    ./locale.nix
    ./vim.nix

    # user
    ./users/user.nix
  ];

  # automatically update and reboot early in the morning
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "6:00";
    randomizedDelaySec = "60min";
  };

  # set of globally (not user-specific) available packages
  environment.systemPackages = with pkgs; [
    # hardware readout
    dmidecode
    pciutils
    usbutils

    # monitoring
    htop
    bottom
    s-tui

    # network debugging
    nmap
    tcpdump
    termshark

    # revision control
    git

    # sensors
    lm_sensors

    # utils
    curl
    file
    fd
    ripgrep
    tmux
    wget
  ];
}
