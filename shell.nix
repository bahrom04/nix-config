{pkgs ? import <nixpkgs> {}}: let
  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      pip
      APScheduler
      loguru
      flit-core
      python-dotenv
      pytz
      requests
      tenacity
      telethon
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
