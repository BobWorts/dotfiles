{local, ...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = local.gitUserName;
      user.email = local.gitUserEmail;

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch.prune = true;
      branch.sort = "-committerdate";
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

  # Stylix owns colors, delta changes layout
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
