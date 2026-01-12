{ pkgs, ... }:
let
  php = pkgs.php82.withExtensions (
    _: with pkgs.php.extensions; [
      curl
      dom
      mbstring
      #json
      pdo_mysql
      mbstring
    ]
  );
in
{

  environment.systemPackages = with pkgs; [
    php
    phpPackages.composer
    graalvmPackages.graalnodejs
    nodejs_20
    nodejs_22
    nodejs_24
  ];

  # Server/Localhost
  services.httpd = {
    enable = true;
    adminAddr = "webmaster@example.org";
    enablePHP = true;
    extraModules = [ "php" ];
  };
  services.httpd = {
    virtualHosts."main.org" = {
      documentRoot = "/var/www/main.org";
      #forceSSL = true;
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

}

