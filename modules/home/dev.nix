{
  lib,
  pkgs,
  local,
  ...
}: {
  config = lib.mkIf (local.useDev or false) {
    home.packages = with pkgs; [
      cmake
      ninja
      gnumake
      xmake
      clang-tools # clangd, clang-format, clang-tidy
      gdb
      ccache
      pkg-config
      gcc
    ];
  };
}
