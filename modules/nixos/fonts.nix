{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      maple-mono.NF # Patched with Nerd Font glyphs
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    enableDefaultPackages = true;

    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        monospace = ["Maple Mono NF"];
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
