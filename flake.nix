{
  description = "Gram-Discord-Presence";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crane.url = "github:ipetkov/crane";
  };

  outputs =
    {
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          inputs = {
            treefmt-nix = treefmt-nix;
          };
        in
        import ./nix/formatter.nix { inherit pkgs inputs; }
      );

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.runCommand "gram-discord-presence" { } ''
            mkdir -p "$out/bin"
            cat > "$out/bin/gram-discord-presence" <<'EOF'
            #!/bin/sh
            echo "gram-discord-presence"
            EOF
            chmod +x "$out/bin/gram-discord-presence"
          '';
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.cargo
              pkgs.rustc
              pkgs.rustfmt
              pkgs.clippy
              pkgs.pkg-config
            ];

            shellHook = ''
              export RUST_BACKTRACE=1
            '';
          };
        }
      );
    };
}
