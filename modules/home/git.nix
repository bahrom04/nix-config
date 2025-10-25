{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "bahrom04";
    userEmail = "magdiyevbahrom@gmail.com";

    signing = {
      signByDefault = true;
      key = "6F392032DFAA7D70C243AE2CB21C6C3287D8517F";
    };

    extraConfig = {
      init.defaultBranch = "main";
      http.sslVerify = false;
      pull.rebase = false;
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
