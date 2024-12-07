{
  inputs,
  ...
}:
{
  imports = [ inputs.devenv.flakeModule ];
  perSystem =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      devenv.shells.default = {
        name = "aoc24-ocaml-shell";

        devenv.root =
          let
            file = builtins.readFile inputs.devenv-root.outPath;
          in
          pkgs.lib.mkIf (file != "") file;

        languages = {
          nix.enable = true;
          ocaml.enable = true;
        };

        packages = with pkgs; [
          just
          config.treefmt.build.wrapper
        ];

        enterShell = ''
          cat <<EOF

            🐚✒️ Get started: 'just <recipe>'
            `just`

          EOF
        '';
      };
    };
}
