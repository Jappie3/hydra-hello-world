{
  description = "Rust Hello World program for testing Hydra";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.tree;

    hydraJobs."master" = self.defaultPackage;
    hydraJobs."test" = pkgs.runCommand "mycommand" {} ''
      echo hello
    '';
  };
}
