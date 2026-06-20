{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "bahrom04";
      user.email = "magdiyevbahrom@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        http.sslVerify = false;
        pull.rebase = false;
        # safe.directory = [
        #   "/home/bahrom/workplace/bahrom04/nix-config"
        #   # Add other safe directories here if needed
        # ];
      };
    };
    signing = {
      signByDefault = true;
      key = "F90FF3D1B272109172B3129483A14C9C2DBD6894";
    };
    # Git ignores
    ignores = [
      ".idea"
      ".DS_Store"
      "nohup.out"
      "node_modules"
      "result"
      ".direnv"
      "target"
    ];
  };
}
