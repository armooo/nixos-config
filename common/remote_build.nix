{}: {
  nix.buildMachines = [
    {
      hostName = "armooo-desktop.ts.armooo.net";
      systems = ["x86_64-linux", "aarch64-linux"];
      maxJobs = 64;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }
  ];
  nix.distributedBuilds = true;
}
