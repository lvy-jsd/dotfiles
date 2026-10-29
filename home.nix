  { config, pkgs, inputs, ... }:
  
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
        ls = "eza --icons";
        ll = "eza -l --icons --git";
	la = "eza -la --icons --git";
	tree = "eza --tree --icons";
	cat = "bat --paging=never";
	rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#ilo";
	conf = "nvim ~/dotfiles";
	gs = "git status";
	ga = "git add";
	gc = "git commit -m";
	gp = "git push";
      };

      #
      history = {
        size = 10000;
	save = 10000;
	share = true; #
      };
    };

    #
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      font = "JetBrainsMono Nerd Font 12";
      extraConfig = {
        modi = "drun,run,window";
	show-icons = "APPs";
	drun-match-fields = "name,generic,exec,categories";
      };
    };

    #
    home.packages = with pkgs; [
      #
      inputs.zen-browser.packages."${pkgs.system}".default

      #
      waybar
      swww
      swaynotificationcenter
      brightnessctl
      wireplumber
      libnotify

      #
      fastfetch  
      htop
      which
      tree
      ripgrep
      fd
      bat
      eza
    ];

    #
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
	format = "$directory$git_branch$git_status$rust$character";
	directory = {
	  style = "bold lavender";
	  truncation_length = 3;
	};
	git_branch = {
	  symbol = " ";
	  style = "bold mauve";
	};
	git_status = {
	  style = "red";
	};
	rust = {
	  symbol = " ";
	  style = "bold peach";
	  format = "via [$symbol($version )]($style)";
	};
	character = {
	  success_symbol = "[>](bold green)";
	  error_symbol = "[>](bold red)";
	};
      };
    };

    #
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    
    #
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainMono Nerd Font";
	size = 12.0;
      };
      settings = {
        background_opacity = "0.85";
	window_padding_width = 12;
	cursor_shape = "beam";
	cursor_blink_interval = "0.5";
	confirm_os_window_close = 0;
	enable_audio_bell = false;
	background = "#1e1e2e";
	foreground = "#cdd6f4";
	selection_background = "#f5e0dc";
	selection_foreground = "#1e1e2e";
	cursor = "#f5e0dc";
	active_tab_foreground = "#11111b";
	active_tab_background = "#cba6f7";
      };
    };

    #
    xdg.configFile."niri/config.kdl".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config.kdl";

  }
