# Rudō (流道) Theme

A Zen Buddhism-inspired theme for Omarchy/Hyprland - stone grays, subtle moss greens, muted earth tones. Emphasizes Kanso (simplicity), Shizen (naturalness), and Seijaku (tranquility).

## Design Principles

- **Kanso (簡素)**: Simplicity - clean, uncluttered, essential elements only
- **Shizen (自然)**: Naturalness - natural materials, organic colors
- **Seijaku (静寂)**: Tranquility - calm, stillness, peaceful atmosphere
- **Ma (間)**: Negative space - breathing room, emptiness as design element

## Color Palette

Uses the **Everforest** color palette - a warm and soft green-based color scheme designed to be easy on the eyes.

- **Background**: `#2d353b` / `#272e33` - Warm dark green-gray
- **Foreground**: `#d3c6aa` - Soft warm beige
- **Red**: `#e67e80` - Soft coral red
- **Orange**: `#e69875` - Warm orange
- **Yellow**: `#dbbc7f` - Muted yellow
- **Green**: `#a7c080` - Soft green (primary accent)
- **Blue**: `#7fbbb3` - Teal blue
- **Aqua/Cyan**: `#83c092` - Soft aqua
- **Magenta**: `#d699b6` - Soft pink
- **Black**: `#343f44` / `#475258` - Dark green-gray
- **White**: `#859289` / `#9da9a0` - Light gray-green

## Fonts

- **Primary**: JetBrainsMono Nerd Font (monospace)
- Optimized for readability and modern aesthetics

## Installation

1. Copy the theme to Omarchy themes directory:
   ```bash
   cp -r ~/dotfiles/omarchy/themes/rudo ~/.local/share/omarchy/themes/
   ```

2. Set the theme:
   ```bash
   omarchy-theme-set rudo
   ```

3. Or symlink from dotfiles:
   ```bash
   ln -s ~/dotfiles/omarchy/themes/rudo ~/.local/share/omarchy/themes/rudo
   ```

## Cursor IDE Configuration

The theme includes a comprehensive Cursor IDE configuration file (`cursor.json`) with Everforest colors and cursor styling:

- **Cursor styling**: Smooth blinking line cursor with Everforest colors
- **Editor colors**: Full Everforest color customization for editor, sidebar, status bar, and terminal
- **Font**: JetBrainsMono Nerd Font with ligatures

The `cursor.json` file contains all the settings. You can manually copy the settings from `cursor.json` to `~/.config/Cursor/User/settings.json`, or use Omarchy's theme system which will apply the theme automatically.

## Customization

Edit the theme files in `~/dotfiles/omarchy/themes/rudo/` to customize colors, fonts, and other settings.

