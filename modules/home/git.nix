{...}: {
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

        safe.directory = [
          "/home/bahrom/workplace/bahrom04/nix-config"
          # Add other safe directories here if needed
        ];
      };
    };

    signing = {
      signByDefault = true;
      key = "6F392032DFAA7D70C243AE2CB21C6C3287D8517F";
    };

    # Git ignores
    ignores = [
      ".idea"
      ".DS_Store"
      "nohup.out"
      "node_modules"
    ];
  };
}
