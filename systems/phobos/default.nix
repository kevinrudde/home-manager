{ pkgs
, home-manager
, flake
, lib
, config
, ...
}: {
  imports = [
    ../shared/yabai.nix
    ../shared/skhd.nix
    ../shared/brew.nix
    ../shared/system.nix
    ../shared/fonts.nix
  ];

  users.users.kevin = {
    home = "/Users/kevin";
    shell = "${pkgs.fish}/bin/fish";
  };

  home-manager.users.kevin = { 
    imports = [
      ../../home/phobos.nix
    ];
  };


  nix.gc = {
    automatic = true;
    options = "--delete-older-than 2d";
    interval = {
      Hour = 5;
      Minute = 0;
    };
  };

  environment.systemPackages = with pkgs; [
    raycast
  ];

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  environment.shells = [ "${pkgs.fish}/bin/fish" ];

  documentation.enable = false;
  documentation.man.enable = false;

  time.timeZone = "Europe/Berlin";

  # Nix config from https://github.com/DeterminateSystems/nix-installer

  nix = {
    # package = pkgs.nixVersions.nix_2_23;
    # extraOptions = ''
    #   experimental-features = nix-command flakes auto-allocate-uids
    #   builders-use-substitutes = true
    #   auto-allocate-uids = true
    #   builders = @/etc/nix/machines
    #   log-lines = 100
    #   nix-path = nixpkgs=${flake.inputs.nixpkgs}
    #   extra-platforms = x86_64-darwin aarch64-darwin
    # '';
    
    settings.trusted-users = [ "root" "kevin" ];
  };

}
