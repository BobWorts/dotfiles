{local, ...}: {
  programs.git = {
    enable = true;

    settings = {
      # ⇩ Identity comes from local.nix.
      user.name = local.gitUserName;
      user.email = local.gitUserEmail;

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      merge.conflictStyle = "zdiff3";
      diff.colorMoved = "default";

      alias = {
        st = "status -sb";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
      };
    };
  };

  # delta: syntax-highlighted, side-by-side pager for git output (not themed by Stylix).
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };

  programs.lazygit.enable = true;
}
