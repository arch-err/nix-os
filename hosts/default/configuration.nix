# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hacking-tools.nix
    ./main-user.nix
    inputs.home-manager.nixosModules.default
    inputs.nixvim.nixosModules.nixvim
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  programs.nixvim = {
    enable = true;

    colorschemes.nord = {
      enable = true;
      settings = {
        disable_background = true;
        enable_sidebar_background = true;
      };
    };

    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    globals.mapleader = " "; # Sets the leader key to comma

    options = {
      guicursor = "";
#
      title = true;
      titlestring = "neovim";
#      
      nu = true;
      relativenumber = false;
#      
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
#
      smartindent = true;
#
      wrap = true;
      showcmd = false;
#
      swapfile = false;
      backup = false;
      #undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir";
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      # isfname:append("@-@");
      updatetime = 50;
      # colorcolumn = "80";
#
      mouse = "a";
      completeopt = "menuone,noselect";
    };

    keymaps = [
      # {
      #   mode = "n";
      #   key = "<C-'>";
      #   options.silent = true;
      #   # action = "\\"vyiw:%s/v/v/g<Left><Left>";
      # }
      {
        mode = "n";
        key = "<leader>z";
        options.silent = true;
        action = "zfip";
      }
      {
        mode = "n";
        key = "U";
        options.silent = true;
        action = "<C-r>";
      }
      {
        mode = "n";
        key = "<leader>r";
        options.silent = true;
        action = ":!vimrunner <C-r>% & disown<CR><CR>";
      }
    ];
    autoCmd = [
      {
          event = "BufWinLeave";
          pattern = "*.*";
          command = "mkview";
      }
      {
          event = "BufWinEnter";
          pattern = "*.*";
          command = "silent! loadview";
      }
    ];

    plugins = {
      # lualine.enable = true;
      auto-save.enable = true;
      commentary.enable = true;
      surround.enable = true;
      nvim-autopairs.enable = true;
      which-key.enable = true;
      noice.enable = true;
      rainbow-delimiters.enable = true;
      nvim-tree.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
        };
      };
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          # rust-analyzer.enable = true;
        };
      };
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
            modes = ["i" "s"];
          };
        };
      };
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "zpctr"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "archerr" = import ./archerr-home.nix;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  main-user.enable = true;
  main-user.userName = "archerr";

  hacking-tools.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    file
    psmisc # killall, pstree, and some more
    swww
    wlogout
    plymouth
    breeze-plymouth
    pulseaudio
    pavucontrol
    zsh
    yazi
    starship
    font-manager
    fzf
    lsd
    bat
    nordzy-cursor-theme
    nordzy-cursor-theme
    xfce.thunar
    rofi
    kitty
    git
    alejandra
    duf
    du-dust
    ripgrep
    sshfs-fuse
    feroxbuster
    wl-clipboard
    eww
    burpsuite
    dirb
    gobuster
    wfuzz
    ffuf
    wpscan
    urlhunter
    sqlmap
    swaynotificationcenter
    swayosd
    alacritty
    tmux
    zellij
    wget
    hashcat
    john
    thc-hydra
    yq
    jq
    zathura
    prettyping
    btop
    openssl
    rustc
    # "perl5.38.2-App-vidir"
    nodejs
    python3Full
    qemu
    virt-manager
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code-symbols
    fira-mono
    fira-code
    fira
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  security.sudo.wheelNeedsPassword = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  system.stateVersion = "23.11"; # Did you read the comment?
}
