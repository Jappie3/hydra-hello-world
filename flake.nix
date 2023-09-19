{
  description = "Rust Hello World program for testing Hydra";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.default = pkgs.rustPlatform.buildRustPackage {
      name = "package-name";
      pname = "hello-world";
      src = ./.;
      #cargoBuildFlags = "-p hello-world";
      cargoLock = {
        lockFile = ./Cargo.lock;
      };
    };

    hydraJobs."master" = {
      job = self.packages.x86_64-linux.default;
    };
    hydraJobs."test" = pkgs.runCommand "mycommand" {} ''
      echo hello
    '';
  };
}
