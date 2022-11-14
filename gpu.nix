{ pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      # compute
      intel-compute-runtime

      # encode/decode
      vaapiIntel
      intel-media-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];
}
