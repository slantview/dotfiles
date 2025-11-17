# Rudō (流道) Theme

A Zen Buddhism-inspired theme for Omarchy/Hyprland - stone grays, subtle moss greens, muted earth tones. Emphasizes Kanso (simplicity), Shizen (naturalness), and Seijaku (tranquility).

## Design Principles

- **Kanso (簡素)**: Simplicity - clean, uncluttered, essential elements only
- **Shizen (自然)**: Naturalness - natural materials, organic colors
- **Seijaku (静寂)**: Tranquility - calm, stillness, peaceful atmosphere
- **Ma (間)**: Negative space - breathing room, emptiness as design element

## Color Palette

Uses a warm and soft green-based color scheme designed to be easy on the eyes. The theme implements a **unified color palette system** with consistent naming across all applications.

### Core Palette

- **Backgrounds**: 
  - `bg-primary` (`#2d353b`) - Main UI background
  - `bg-secondary` (`#272e33`) - Sidebars, panels
  - `bg-dark` (`#343f44`) - Borders, darkest elements
  - `bg-mid` (`#3d484d`) - Widgets, inactive elements
  - `bg-hover` (`#475258`) - Hover states

- **Foregrounds**:
  - `fg-primary` (`#d3c6aa`) - Main text color (soft warm beige)
  - `fg-secondary` (`#859289`) - Inactive text
  - `fg-bright` (`#9da9a0`) - Highlights, active text
  - `fg-dim` (`#868d80`) - Dimmed text

- **Accent**:
  - `accent-primary` (`#FF8C00`) - Saffron orange (Tibetan monk robe color) - primary accent for active states, highlights, focus

### Extended Palette

- **Red Family**: `red` (`#e67e80`), `red-bright` (`#f85552`), `red-muted` (`#a55555`)
- **Orange Family**: `orange` (`#e69875`), `orange-muted` (`#d67923`), `orange-bright` (`#FFA500`)
- **Yellow**: `yellow` (`#dbbc7f`) - Warnings, highlights
- **Green Family**: `green` (`#a7c080`), `green-bright` (`#b5da61`) - Success states
- **Blue/Cyan Family**: `blue` (`#7fbbb3`), `cyan` (`#83c092`), `teal-dark` (`#156465`) - Links, info
- **Magenta/Purple**: `magenta` (`#d699b6`), `purple-dark` (`#2c244a`)
- **Brown/Tan**: `brown` (`#b87850`), `beige-light` (`#f8d094`)

All theme files use this unified naming scheme for consistency. See `colors.txt` for the complete palette reference with usage guidelines.

## Fonts

- **Primary**: JetBrainsMono Nerd Font (monospace)
- Optimized for readability and modern aesthetics

## Installation

### Quick Install (Recommended)

1. **Symlink the theme from dotfiles:**
   ```bash
   ln -s ~/dotfiles/omarchy/themes/rudo ~/.local/share/omarchy/themes/rudo
   ```

2. **Set the theme:**
   ```bash
   omarchy-theme-set rudo
   ```

3. **Install theme files via Makefile** (from dotfiles directory):
   ```bash
   cd ~/dotfiles
   make install
   ```
   This will automatically link:
   - Zen Browser theme (if Zen Browser is installed)
   - Spicetify theme (if Spicetify is installed)
   - All other dotfiles and configurations

### Manual Install

1. Copy the theme to Omarchy themes directory:
   ```bash
   cp -r ~/dotfiles/omarchy/themes/rudo ~/.local/share/omarchy/themes/
   ```

2. Set the theme:
   ```bash
   omarchy-theme-set rudo
   ```

## Theme Files

The theme includes configurations for:

- **Window Manager**: Hyprland (borders, colors)
- **Status Bar**: Waybar (config + style)
- **Terminal Emulators**: Alacritty, Kitty, Ghostty
- **Shell Prompt**: Starship
- **Editor**: Neovim, Cursor/VSCode
- **Lock Screen**: Hyprlock
- **Notifications**: Mako
- **System Monitor**: btop
- **OSD**: SwayOSD
- **File Manager**: Walker
- **Browser**: Zen Browser (userChrome.css)
- **Music Player**: Spotify (Spicetify theme)
- **Icons**: Papirus-Dark
- **Background**: Custom wallpaper

### Cursor/VSCode Configuration

The theme includes comprehensive Cursor IDE and VSCode configuration files:

- **Cursor** (`cursor.json`): Full color customization with smooth blinking line cursor
- **VSCode** (`vscode.json`): Theme with color customizations
- **Font**: JetBrainsMono Nerd Font with ligatures

Settings are applied automatically via Omarchy's theme system, or can be manually copied to `~/.config/Cursor/User/settings.json` or VSCode settings.

### Zen Browser Theme

The theme includes a `zen-browser/userChrome.css` file for customizing Zen Browser's interface. The theme is automatically linked during installation via the Makefile.

**To enable:**
1. Open Zen Browser and go to `about:config`
2. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
3. Restart Zen Browser

### Spotify Theme (Spicetify)

The theme includes a Spicetify theme in `spicetify/` directory with:
- `config.ini` - Spicetify configuration
- `color.ini` - Color scheme configuration
- `user.css` - Additional CSS customizations

**To apply:**
1. Install Spicetify: `yay -S spicetify-cli` (or from source)
2. Run: `spicetify backup apply`
3. The theme files are automatically linked during installation
4. Apply the theme: `spicetify config current_theme rudo && spicetify config color_scheme rudo && spicetify apply`

## Color Reference

The theme uses a **unified color palette system** with consistent naming across all applications:

- **CSS files** (Waybar, Zen Browser, Spicetify, etc.) use CSS variables like `--bg-primary`, `--fg-primary`, `--accent-primary`
- **GTK CSS files** use `@define-color` directives with the same naming scheme
- **Configuration files** (Kitty, Alacritty, etc.) use hex values that match the unified palette
- **All files** reference `colors.txt` as the master color reference

### Using the Unified Palette

When customizing the theme:

1. **Reference `colors.txt`** - This is the master color reference with all colors, descriptions, and usage guidelines
2. **Use semantic names** - Prefer `bg-primary` over `#2d353b` for better maintainability
3. **Follow naming conventions**:
   - `bg-*` for backgrounds
   - `fg-*` for foregrounds
   - `accent-*` for accent colors
   - Color family names (red, orange, yellow, green, blue, cyan, magenta, purple, brown)
   - Variants: `-bright`, `-muted`, `-dark`

### Color Usage Guidelines

- **Primary Accent**: `accent-primary` (`#FF8C00`) - Use for active states, highlights, focus
- **Error/Warning**: `red` (`#e67e80`) - Errors, warnings, destructive actions
- **Success**: `green` (`#a7c080`) - Success states, positive feedback
- **Info**: `blue` (`#7fbbb3`) - Links, informational elements
- **Hover**: `bg-hover` (`#475258`) or `bg-mid` (`#3d484d`)
- **Inactive**: `fg-secondary` (`#859289`)

See `colors.txt` for complete color reference with detailed usage notes and design philosophy.

## Customization

Edit the theme files in `~/dotfiles/omarchy/themes/rudo/` to customize colors, fonts, and other settings. The theme uses symlinks, so changes to the dotfiles will be reflected immediately.

### Modifying Colors

1. **Update `colors.txt`** - This is the master reference
2. **Update theme files** - Modify the specific application files (waybar.css, userChrome.css, etc.)
3. **Maintain consistency** - Use the unified naming scheme across all files

### File Structure

```
rudo/
├── colors.txt              # Master color palette reference
├── waybar.css             # Waybar color definitions (unified palette)
├── waybar/                # Waybar configuration
├── zen-browser/           # Zen Browser theme
├── spicetify/             # Spotify/Spicetify theme
├── cursor.json            # Cursor IDE theme
├── vscode.json            # VSCode theme
├── kitty.conf             # Kitty terminal theme
├── alacritty.toml         # Alacritty terminal theme
├── hyprland.conf          # Hyprland window manager
├── hyprlock.conf          # Lock screen
├── swayosd.css            # OSD styling
├── walker.css             # File manager styling
└── ...                    # Other theme files
```

