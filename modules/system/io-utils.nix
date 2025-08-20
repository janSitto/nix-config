{pkgs, ...}: {
    services = {
        udisks2.enable = true;
        gvfs.enable = true;
        printing.enable = true;
        libinput.enable = true;
    };
    programs = {
        mtr.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
    };

}