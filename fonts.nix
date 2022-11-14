{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
    };

    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      fantasque-sans-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      dejavu_fonts
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      aileron
    ];
  };

  nixpkgs.overlays = [
    # reduce the number of fonts shipped by nerdfonts package
    (self: super: {
      nerdfonts = super.nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
        ];
      };
    })
  ];
}
