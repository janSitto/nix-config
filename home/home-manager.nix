{
  pkgs,
  inputs,
  username,
  ...
}:
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

  systemd.tmpfiles.rules =
    let
      user = "${username}";
      iconPath = userpfp;
    in
    [
      "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
      "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
    ];

}

