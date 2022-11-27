# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # waydroid support
      ./waydroid.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # use latest linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cnijfilter2 pkgs.cnijfilter_4_00 ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  # programs.ssh.startAgent = true;

  # enable plex
  services.plex = {
    enable = true;
    openFirewall = true;
  };
  # do not start on system boot
  systemd.services.plex.wantedBy = lib.mkForce [];

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.beef = {
    isNormalUser = true;
    description = "Deadbeef";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    packages = with pkgs; [
      firefox
      kate
      wqy_microhei
      skanlite
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ];

# we are using home manager, so no system packages here
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     git
     wineWowPackages.staging
     vlc
     ark
#     wget
#     vscode
#     jetbrains.idea-community
  ];
  fonts.fonts = with pkgs; [
     iosevka
     wqy_microhei
  ];

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.enableRimeData = true;
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-rime ];
  nixpkgs.config.allowUnfree = true;
  hardware.bluetooth.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.allowedTCPPorts = [ 8010 8080 ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
  
  # tuna mirror
  nix.settings = {
	auto-optimise-store = true;
#	substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
	experimental-features = [ "nix-command" "flakes "];
  };

  # fix eduroam
  systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText "openssl.cnf" ''
    openssl_conf = openssl_init
    [openssl_init]
    ssl_conf = ssl_sect
    [ssl_sect]
    system_default = system_default_sect
    [system_default_sect]
    Options = UnsafeLegacyRenegotiation
  '';
  # enable virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "beef" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
