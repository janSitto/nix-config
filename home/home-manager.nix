{pkgs, inputs, username, ...}: 
let

  userpfp = ./userpfp.jpg;
  wallpaper = ./wallpaper.png;

in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${username} = import ./home-config.nix;
    extraSpecialArgs = {
      inputs = inputs;
      username = username;
      userpfp = userpfp;
      wallpaper = wallpaper;
    };
  };
}