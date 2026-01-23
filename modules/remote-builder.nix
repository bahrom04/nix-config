{...}: {
  nix = {
    buildMachines = [
      {
        hostName = "ns3.kolyma.uz";
        sshUser = "bahrom04";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshKey = "~/.ssh/id_ed25519";
        maxJobs = 4;
        speedFactor = 2;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [];
      }
    ];
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
