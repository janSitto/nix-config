{pkgs, ...}: {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
}