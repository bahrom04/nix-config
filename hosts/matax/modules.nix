{pkgs, ...}: let
  eimzo = pkgs.callPackage ../../e-imzo.nix {};
in {
  # services.e-imzo.package = pkgs.callPackage ../../e-imzo.nix {};
  # modules.xinux.eimzoIntegraion.enable = true;

  systemd.user.services.e-imzo = {
    enable = true;
    description = "E-IMZO, uzbek state web signing service";
    documentation = ["https://github.com/xinux-org/e-imzo"];

    after = [
      "network-online.target"
      "graphical.target"
    ];
    wants = [
      "network-online.target"
      "graphical.target"
    ];
    wantedBy = ["default.target"];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      ExecStartPre = [
        (pkgs.writeShellScript "e-imzo-check-port-availability" ''
          until [ -z "$(${pkgs.iproute2}/bin/ss -tuln | grep -E ':(64646|64443)\>')" ]; do
            sleep 1
          done
        '')
      ];
      ExecStart = pkgs.lib.getExe eimzo;

      NoNewPrivileges = true;
      SystemCallArchitectures = "native";
    };
  };
  modules.xinux.language = "uz_UZ.UTF-8";
}
