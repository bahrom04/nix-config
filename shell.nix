{
  inputs,
  pkgs,
  ...
}: let
  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      pip
      python-dotenv
      pytz
      requests
      setuptools
    ]);
in
  pkgs.stdenv.mkDerivation {
    name = "nix";


    nativeBuildInputs = with pkgs; [
      nixd
      statix
      deadnix
      alejandra
      age
      sops
      rng-tools
      openssl

      pythonEnv
      poetry
    ];

    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  }
