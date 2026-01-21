{
  pkgs,
  config,
  system,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = (
        (
          with vscode-extensions;
          [
            rust-lang.rust-analyzer
            bbenoist.nix
            ms-python.python
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-ssh
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "remote-ssh-edit";
              publisher = "ms-vscode-remote";
              version = "0.47.2";
              sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
            }
            {
              name = "java";
              publisher = "redhat";
              version = "1.40.0";
              sha256 = "1z4zhz55l9gy296rqm33pbbpvqxasnj6dmfkkvyw79bmd8sspa6i";
            }
          ]
        )
      );
    })
  ];
}
