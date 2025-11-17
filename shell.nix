# This is required for impure linking reasons but will not take up much space on the hard drive
# nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs
# nix-channel --update

let
  nixpkgs = fetchGit {
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "release-25.05";
  };
  pkgs = import nixpkgs {};
  rffmpeg = pkgs.callPackage ./rffmpeg.nix { };
in

pkgs.mkShellNoCC { # Make a shell without a c compiler (Use mkShell to get a c compiler)
  packages = [ # Package to include in the shell
      pkgs.python313Packages.click
      pkgs.python313Packages.yamllint
      pkgs.cowsay
      pkgs.ffmpeg
      rffmpeg
  ];

  preShellHook = ''
      sudo mkdir -p /var/lib/rffmpeg
      sudo chown -R robot /var/lib/rffmpeg
      sudo chmod 777 -R /var/lib/rffmpeg
  '';

  shellHook = ''
      echo ${pkgs.cowsay}
      cowsay "Welcome to the rffmpeg build env"
      echo ${rffmpeg}
      echo ${rffmpeg}/bin/ffmpeg
      type ${rffmpeg}/bin/ffmpeg
      sudo ${rffmpeg}/bin/rffmpeg init
      ${rffmpeg}/bin/rffmpeg add 192.168.1.40
      ${rffmpeg}/bin/rffmpeg status
      '';
}
