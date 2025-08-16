{pkgs, ...}: {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    environment.systemPackages = with pkgs; [ 
      pavucontrol 
      wireplumber
      libcanberra-gtk3
      noise-suppression-for-voice
    ];
}