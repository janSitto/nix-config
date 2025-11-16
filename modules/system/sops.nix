{pkgs, username, ...}: {
    environment.systemPackages = with pkgs; [ sops ];
    sops = {
        age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
        defaultSopsFile = ../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
    };

}