{
  pkgs,
  config,
  system,
  inputs,
  ...
}:
{

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  };
  environment.systemPackages = with pkgs; [

    # Sem Categoria
    wine
    wayvnc
    gnupg
    vlc
    mpv
    pavucontrol

    inputs.zen-browser.packages."${system}".twilight

    # Terminal
    fastfetch
    btop
    powertop
    lm_sensors
    cowsay
    fortune
    cbonsai
    cmatrix
    asciiquarium
    shell-gpt
    wget

    # Arquivos
    #xfce.thunar
    #xfce.thunar-volman
    nautilus
    gvfs
    glib
    udiskie
    gnome-disk-utility
    rar
    unrar
    zip
    unzip
    gnutar
    xz
    gzip
    gpa

    # Jogos
    #prismlauncher
    #r2modman
    #lumafly
    #ckan

    # Produtividade
    obsidian
    anki-bin
    libreoffice

    # Dev
    openssl
    pkg-config
    docker
    greenfoot
    jdk
    jdk8
    jdk11
    jdk21
    openjfx21
    #openjfx11
    #openjfx8 
    webkitgtk_6_0
    git
    rustup
    rustc
    cargo
    gcc
    qt6.full
    scrcpy
    android-tools
    android-studio
    jetbrains.idea-community-bin
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

    # 3D & 2D
    freecad-wayland
    librecad
    cura-appimage
    orca-slicer
    inkscape
    blender

  ];
}
