# bootstrap.nix
# Designed as first-boot configuration (bootstrap) for impermanence systems
# Run nixos-generate-config --root=/mnt for hardware scan then overwrite with this as configuration.nix
# Then you can reboot and get SecureBoot, TPM, /persist, and whatever else set up and use flakes to install
{ pkgs, lib, ... }:
 {
  imports =
    [
      <nixos-hardware/framework/12th-gen-intel>
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; 
  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  # Enable networking
  networking.hostName = "Chris_nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";
  
    console = {
    packages=[ pkgs.terminus_font ];
    font="${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.
  };


  # Enable the GNOME Desktop Environment with wayland.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
    layout = "us";
    xkbVariant = "";
  };

  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
]) ++ (with pkgs.gnome; [
  cheese # webcam tool
  gnome-music
  gnome-terminal
  gedit # text editor
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
]);

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cwestpha = {
    isNormalUser = true;
    description = "Christopher Westphal";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      bind
      pkgs.vscode
      git
      starship
      pfetch
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.brave
    pkgs.btop
    pkgs.
    pkgs.freetype
    pkgs.powershell
    pkgs.terminus-nerdfont
    pkgs.vscode
    pkgs.neofetch
    pkgs.vmware-horizon-client
    pkgs.wget
    pkgs.appimage-run
    gcc
    gnupg
    sbctl
    tpm2-tss
    git
    libgda
    pkgs.gnome.gnome-tweaks
    pkgs.gnomeExtensions.pano
    pkgs.gnomeExtensions.gsnap
    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.no-overview
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.blur-my-shell
    niv
  ];

 # Font Stuff
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
	      monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
	      serif = [ "Noto Serif" "Source Han Serif" ];
	      sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
};

  # Flatpak Settings
  services.flatpak.enable = true;
  services.dbus.enable = true;

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = lib.mkForce false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;  
  system.autoUpgrade.allowReboot = true; 
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";

  system.stateVersion = "23.05";

  nix.settings.experimental-features = "nix-command flakes";

}
