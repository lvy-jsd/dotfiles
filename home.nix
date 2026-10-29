  { config, pkgs, ... }:
  
  {
    #
    home.username = "lvy";
    home.homeDirectory = "/home/lvy";
    home.stateVersion = "24.11";

    #
    programs.home-manager.enable = true;

    #
    programs.zsh = {
      enable = true;
      #
      autosuggestion.enable = true;
      #
      syntaxHighlighting.enable = true;

      #
      shellAliases = {
        ll = "ls -l";
	rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#ilo";
	conf = "nvim ~/dotfiles";
      };

      #
      history = {
        size = 10000;
	save = 10000;
	share = true; #
      };
    };

    #
    home.packages = with pkgs; [
      fastfetch  
      htop
      which
      tree
      bat
      eza
    ];
    
    #
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainMono Nerd Font";
	size = 12.0;
      };
      settings = {
        background_opacity = "0.95";
	confirm_os_window_close = 0;
	enable_audio_bell = false;
      };
    };

    #
    xdg.configFile."niri/config.kdl".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config.kdl";

  }
