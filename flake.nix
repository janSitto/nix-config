{

  description = "janSitto nix-config multi-host flake";
  
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

  };
  
  outputs = { self, nixpkgs, home-manager, sops-nix, nixvim, zen-browser, ...}@inputs: {
    nixosModules = {

      # Home-manager & Home config
      home = import ./home/home-manager.nix;
      home-config = import ./home/home-config.nix;
      # Modules
      waybar = import ./modules/home/waybar/waybar.nix;
      wofi = import ./modules/home/wofi/wofi.nix;
      gtk = import ./modules/home/gtk.nix;
      qt = import ./modules/home/qt.nix;
      gnome = import ./modules/home/gnome/gnome.nix;
      plasma = import ./modules/home/plasma/plasma.nix;
      hyprland = import ./modules/home/hyprland/hyprland.nix;
      hyprland-config = import ./modules/home/hyprland/hyprland-config.nix;
      hyprpaper = import ./modules/home/hyprland/hyprpaper.nix;
      helix = import ./modules/programs/helix.nix;
      kitty = import ./modules/programs/kitty.nix;
      nixvim = import ./modules/home/nixvim.nix;
      fonts = import ./modules/fonts.nix;
      programs = import ./modules/programs/programs.nix;
      firefox = import ./modules/programs/firefox.nix;
      steam = import ./modules/programs/steam.nix;
      virtualisation = import ./modules/virtualisation.nix;
      # Server Stuff
      duckdns = import ./modules/server/duckdns.nix;
      nginx = import ./modules/server/nginx.nix;
      openssh = import ./modules/server/openssh.nix;
      samba = import ./modules/server/samba.nix;
      screen-off = import ./modules/server/screen-off.nix;
      tailscale-server = import ./modules/server/tailscale-server.nix;
      syncthing = import ./modules/server/syncthing.nix;

      # Secrets/Secret Keeping/Cryptography
      sops = import ./modules/system/sops.nix;

      # System
      grub = import ./modules/system/bootloaders/grub.nix;
      sddm = import ./modules/system/display-managers/sddm.nix;
      nvidia = import ./modules/system/graphics/nvidia.nix;
      bluetooth = import ./modules/system/bluetooth.nix;
      garbage-collector = import ./modules/system/garbage-collector.nix;
      io-utils = import ./modules/system/io-utils.nix;
      pipewire = import ./modules/system/pipewire.nix;
      power = import ./modules/system/power.nix;
      network = import ./modules/system/network/network.nix;
      localhost = import ./modules/system/network/localhost.nix;
      security = import ./modules/system/security.nix;
      timezone = import ./modules/system/timezone.nix;
      xdg = import ./modules/system/xdg.nix;
      xserver = import ./modules/system/xserver.nix;
      tailscale = import ./modules/system/network/tailscale.nix;
      zerotier = import ./modules/system/network/zerotier.nix;

      # Users
      user-jvs = import ./users/jvs.nix;

    };
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = with self.nixosModules; [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          home
          gnome
          hyprland
          sddm
          network
          localhost
          grub
          timezone
          xdg
          xserver
          security
          nvidia
          bluetooth
          garbage-collector
          io-utils
          pipewire
          power
          programs
          firefox
          fonts
          virtualisation
          tailscale
          zerotier
          syncthing
          user-jvs
          sops

          steam
        ];
        specialArgs = {
          system = "x86_64-linux";
          username = "jvs";
          inherit inputs;
        };
      };
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = with self.nixosModules; [
          ./hosts/server/configuration.nix 
          sops-nix.nixosModules.sops
          grub
          duckdns
          nginx
          openssh
          samba
          io-utils
          tailscale-server
          zerotier
          screen-off
          syncthing
          user-jvs
          sops
        ];
        specialArgs = {
          system = "x86_64-linux";
          username = "jvs";
          inherit inputs;
        };
      };
    };  
  };
}
