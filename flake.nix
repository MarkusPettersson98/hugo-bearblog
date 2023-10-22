{
  description = "A Hugo theme based on Bear Blog";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem
      (system:
	  let
            pkgs = import nixpkgs {
              inherit system;
            };
            lib = pkgs.lib;
          in
	  rec 
          {
	    packages.hugo-bearblog = pkgs.stdenv.mkDerivation {
	      name = "hugo-bearblog";
	      src = ./.;
	    };
	    packages.default = self.packages.${system}.hugo-bearblog;
            devShells = {
              default = pkgs.mkShell {
                buildInputs = with pkgs; [ hugo nodejs ];
              };
            };
          }
     );
}
