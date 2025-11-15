# Dotfiles

Modern, cross-platform dotfiles configuration with Neovim, lightweight shell framework, and improved organization. Supports Linux, macOS, and Windows/WSL.

## Features

- **Neovim** configuration with lazy.nvim plugin manager
- **Lightweight shell framework** using zinit (replaces oh-my-zsh)
- **Hyprland** window manager configuration
- **Cross-platform support** for Linux, macOS, and Windows/WSL
- **Modular organization** - easy to customize and maintain
- **Lazy loading** for heavy tools (conda, nvm, etc.)
- **Smart PATH management** with automatic deduplication

## Requirements

### Required
- **Neovim** (0.8+) - [Installation guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **zsh** - Usually pre-installed on macOS and most Linux distributions
- **git** - For cloning and managing the repository

### Optional
- **zinit** - Will be auto-installed if not present
- **lazy.nvim** - Will be auto-installed when Neovim starts
- Various development tools (Go, Python, Node.js, etc.)

## Installation

### Quick Install

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Run the installation
make install
```

### Manual Install

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Create symlinks:**
   ```bash
   # For zsh
   ln -sf ~/dotfiles/zshrc ~/.zshrc
   ln -sf ~/dotfiles/zsh ~/.zsh
   
   # For bash
   ln -sf ~/dotfiles/bashrc ~/.bashrc
   
   # For Neovim
   mkdir -p ~/.config
   ln -sf ~/dotfiles/nvim ~/.config/nvim
   
   # For Hyprland
   mkdir -p ~/.config
   ln -sf ~/dotfiles/hypr ~/.config/hypr
   
   # Other configs
   ln -sf ~/dotfiles/profile ~/.profile
   ln -sf ~/dotfiles/gemrc ~/.gemrc
   ```

3. **Install zinit (if not auto-installed):**
   ```bash
   mkdir -p ~/.local/share
   git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
   ```

4. **Restart your shell:**
   ```bash
   exec zsh
   ```

## File Structure

```
dotfiles/
├── nvim/                    # Neovim configuration
│   ├── init.lua            # Main entry point
│   └── lua/
│       ├── plugins.lua     # Plugin declarations
│       └── config/
│           ├── options.lua # Neovim options
│           ├── keymaps.lua # Key mappings
│           └── autocmds.lua # Autocommands
├── zsh/                     # Modular zsh configuration
│   ├── zshrc               # Main zsh config
│   ├── os-specific.zsh     # OS detection and platform configs
│   ├── paths.zsh           # PATH management
│   ├── aliases.zsh         # Shell aliases
│   ├── functions.zsh       # Custom functions
│   └── completion.zsh      # Completion settings
├── hypr/                    # Hyprland window manager configuration
│   ├── hyprland.conf       # Main Hyprland config
│   ├── autostart.conf      # Autostart applications
│   ├── bindings.conf       # Key bindings
│   ├── envs.conf           # Environment variables
│   ├── input.conf          # Input configuration
│   ├── looknfeel.conf      # Appearance settings
│   ├── monitors.conf       # Monitor configuration
│   ├── hypridle.conf       # Idle daemon config
│   ├── hyprlock.conf       # Lock screen config
│   ├── hyprsunset.conf     # Night light config
│   └── shaders/            # GLSL shader effects
├── zshrc                    # Entry point (sources zsh/zshrc)
├── bashrc                   # Bash configuration
├── profile                  # Profile configuration
├── gemrc                    # Ruby gem configuration
├── vimrc                    # Legacy vimrc (optional)
├── Makefile                 # Installation automation
└── README.md               # This file
```

## Configuration

### Neovim

The Neovim configuration is located in `nvim/` and uses lazy.nvim for plugin management. Key features:

- **LSP support** for Go, Python, TypeScript
- **Treesitter** for better syntax highlighting
- **Telescope** for fuzzy finding
- **nvim-tree** for file exploration
- **Autocompletion** with nvim-cmp

Plugins are automatically installed on first launch. To update plugins, run `:Lazy` in Neovim.

### Hyprland Configuration

The Hyprland configuration is located in `hypr/` and includes:

- **Modular configuration** - Split into multiple files for organization
- **Window management** - Layouts, gaps, and borders
- **Key bindings** - Custom keyboard shortcuts
- **Input configuration** - Mouse, touchpad, and keyboard settings
- **Monitor setup** - Display configuration
- **Visual effects** - Shaders and appearance settings
- **Autostart** - Applications launched on startup
- **Idle/lock** - Screen locking and power management
- **hy3 tiling** - i3-like tiling window manager plugin

The configuration is installed to `~/.config/hypr/`. After installation, restart Hyprland or reload the config with `hyprctl reload`.

### Omarchy Theme - Rudo

A custom Omarchy theme called "rudo" (Japanese-inspired) is included in `omarchy/themes/rudo/`. This theme provides:

- **Clean, minimal design** - Japanese-inspired aesthetic
- **Modern color palette** - Deep dark backgrounds with vibrant blue accents
- **Optimized fonts** - JetBrainsMono Nerd Font for consistency
- **Complete theme files** - waybar, hyprland, alacritty, kitty, neovim, and more

To use the rudo theme:

```bash
# Symlink the theme to Omarchy themes directory
ln -s ~/dotfiles/omarchy/themes/rudo ~/.local/share/omarchy/themes/rudo

# Set as active theme
omarchy-theme-set rudo
```

See `omarchy/themes/rudo/README.md` for more details.

### Shell Configuration

The shell configuration is modular and organized by function:

- **os-specific.zsh**: Detects OS (Linux/macOS/WSL) and sets platform-specific variables
- **paths.zsh**: Manages PATH with automatic deduplication
- **aliases.zsh**: Common aliases for git, docker, etc.
- **functions.zsh**: Custom shell functions
- **completion.zsh**: Zsh completion settings

### Local Overrides

You can create local override files that won't be tracked in git:

- `~/.zshrc_local` - Local zsh overrides
- `~/.bashrc_local` - Local bash overrides

These files are automatically sourced if they exist.

## OS-Specific Notes

### Linux

Most configurations work out of the box. Ensure you have:
- zsh installed: `sudo apt install zsh` (Debian/Ubuntu) or `sudo dnf install zsh` (Fedora)
- Neovim installed from your package manager or [official releases](https://github.com/neovim/neovim/releases)
- Hyprland (if using): Install from your package manager or [official source](https://hyprland.org/)

### macOS

- Homebrew paths are automatically detected (both Intel and Apple Silicon)
- Visual Studio Code integration is included
- Some paths may need adjustment based on your Homebrew installation

### Windows/WSL

- WSL is automatically detected
- Visual Studio Code integration works via `code.exe`
- Paths are adjusted for WSL environment

## Customization

### Adding Plugins

**Neovim:** Edit `nvim/lua/plugins.lua` and add your plugin configuration.

**Zsh:** Edit `zsh/zshrc` to add zinit plugins:
```zsh
zinit light username/plugin-name
```

### Adding Aliases

Edit `zsh/aliases.zsh` or `bashrc` to add custom aliases.

### Adding Functions

Edit `zsh/functions.zsh` to add custom shell functions.

### Changing Colorscheme

Edit `nvim/lua/config/options.lua` and change:
```lua
vim.cmd.colorscheme("your-colorscheme")
```

## Lazy Loading

Heavy tools like conda and nvm are set up for lazy loading. To use them:

```bash
# Load conda
load_conda

# Load nvm
load_nvm

# Load gvm (Go Version Manager)
load_gvm
```

Or uncomment the auto-load lines in `profile` if you want them loaded automatically.

## Troubleshooting

### Neovim plugins not installing

- Ensure you have git installed
- Check your internet connection
- Run `:Lazy` in Neovim to see error messages

### zinit not working

- Ensure zsh is your default shell: `chsh -s $(which zsh)`
- Check that zinit was installed: `ls ~/.local/share/zinit/zinit.git`
- Restart your terminal

### PATH issues

- Check `zsh/paths.zsh` or `bashrc` for path configuration
- Ensure directories exist before adding to PATH
- Use `echo $PATH` to verify paths are set correctly

### OS detection not working

- Check `zsh/os-specific.zsh` for OS detection logic
- Verify `$OSTYPE` variable: `echo $OSTYPE`

## Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull
```

Then restart your shell or source the configs:
```bash
source ~/.zshrc
```

## Uninstallation

To remove the dotfiles:

```bash
cd ~/dotfiles
make clean
```

This will remove all symlinks. Your original files (if backed up) will remain.

## License

[Your License Here]

## Contributing

[Your Contributing Guidelines Here]

