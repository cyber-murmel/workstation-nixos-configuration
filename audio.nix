{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    # compat layers
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
