{ pkgs, ... }: {
  
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
};

  programs = {
    virt-manager.enable = true;
  };


environment.systemPackages = with pkgs; [
    docker-client
  ];
}