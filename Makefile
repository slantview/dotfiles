# Dotfiles Makefile
# Modernized for Neovim, zinit, and cross-platform support

DOTFILES_DIR := $(shell pwd)
HOME_DIR := $(HOME)
CONFIG_DIR := $(HOME_DIR)/.config

# Dotfiles to link
ALL_DOTFILES := zshrc vimrc bashrc gemrc profile
ALL_PRIVATE_DOTFILES := zshrc_local bashrc_local s3cfg

# Directories to link (zsh and nvim have specific targets, so not included here)
ALL_DIRS :=

# All links
ALL_DOTFILE_LINKS := $(ALL_DOTFILES:%=$(HOME_DIR)/.%)
ALL_DIR_LINKS := $(ALL_DIRS:%=$(HOME_DIR)/.%)
ALL_NVIM_LINK := $(CONFIG_DIR)/nvim
ALL_HYPR_LINK := $(CONFIG_DIR)/hypr
ALL_ZSH_LINK := $(HOME_DIR)/.zsh
ALL_PRIVATE_DOTFILE_LINKS := $(ALL_PRIVATE_DOTFILES:%=$(HOME_DIR)/.%)

# Clean targets (exclude zsh and nvim which have specific clean targets)
ALL_CLEAN := $(addprefix clean-,${ALL_DOTFILES})

.PHONY: all install backup check clean help

all: install

help:
	@echo "Available targets:"
	@echo "  make install  - Install all dotfiles (with backup)"
	@echo "  make backup   - Backup existing dotfiles"
	@echo "  make check    - Validate dotfiles configuration"
	@echo "  make clean    - Remove all symlinks"
	@echo "  make help     - Show this help message"

# Main install target
install: backup check-zsh check-nvim $(ALL_DOTFILE_LINKS) $(ALL_DIR_LINKS) $(ALL_NVIM_LINK) $(ALL_HYPR_LINK) $(ALL_ZSH_LINK) starship-config zinit git-aliases send-plugin zen-browser-theme spicetify-theme
	@echo "✓ Installation complete!"
	@echo "  Installed from: $(DOTFILES_DIR)"
	@echo "  Run 'exec zsh' to start using the new configuration"

# Backup existing dotfiles
backup:
	@echo "Creating backups..."
	@mkdir -p $(HOME_DIR)/.dotfiles-backup
	@echo "  Backing up from: $(DOTFILES_DIR)"
	@for file in $(ALL_DOTFILES); do \
		if [ -f $(HOME_DIR)/.$$file ] || [ -L $(HOME_DIR)/.$$file ]; then \
			echo "  Backing up .$$file"; \
			if [ -L $(HOME_DIR)/.$$file ]; then \
				cp -L $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup 2>/dev/null || cp $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup; \
			else \
				cp $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup; \
			fi; \
		fi; \
	done
	@for file in zshrc_local bashrc_local; do \
		if [ -f $(HOME_DIR)/.$$file ] || [ -L $(HOME_DIR)/.$$file ]; then \
			echo "  Backing up .$$file"; \
			if [ -L $(HOME_DIR)/.$$file ]; then \
				cp -L $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup 2>/dev/null || cp $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup; \
			else \
				cp $(HOME_DIR)/.$$file $(HOME_DIR)/.dotfiles-backup/$$file.backup; \
			fi; \
		fi; \
	done
	@for dir in $(ALL_DIRS); do \
		if [ -d $(HOME_DIR)/.$$dir ] || [ -L $(HOME_DIR)/.$$dir ]; then \
			echo "  Backing up .$$dir"; \
			if [ -L $(HOME_DIR)/.$$dir ]; then \
				rm -f $(HOME_DIR)/.dotfiles-backup/$$dir.backup.tar.gz; \
				tar -czf $(HOME_DIR)/.dotfiles-backup/$$dir.backup.tar.gz -C $(HOME_DIR) .$$dir 2>/dev/null || true; \
			else \
				tar -czf $(HOME_DIR)/.dotfiles-backup/$$dir.backup.tar.gz -C $(HOME_DIR) .$$dir 2>/dev/null || true; \
			fi; \
		fi; \
	done
	@if [ -d $(CONFIG_DIR)/nvim ] || [ -L $(CONFIG_DIR)/nvim ]; then \
		echo "  Backing up nvim config"; \
		if [ -L $(CONFIG_DIR)/nvim ]; then \
			rm -f $(HOME_DIR)/.dotfiles-backup/nvim.backup.tar.gz; \
			tar -czf $(HOME_DIR)/.dotfiles-backup/nvim.backup.tar.gz -C $(CONFIG_DIR) nvim 2>/dev/null || true; \
		else \
			tar -czf $(HOME_DIR)/.dotfiles-backup/nvim.backup.tar.gz -C $(CONFIG_DIR) nvim 2>/dev/null || true; \
		fi; \
	fi
	@if [ -d $(CONFIG_DIR)/hypr ] || [ -L $(CONFIG_DIR)/hypr ]; then \
		echo "  Backing up hypr config"; \
		if [ -L $(CONFIG_DIR)/hypr ]; then \
			rm -f $(HOME_DIR)/.dotfiles-backup/hypr.backup.tar.gz; \
			tar -czf $(HOME_DIR)/.dotfiles-backup/hypr.backup.tar.gz -C $(CONFIG_DIR) hypr 2>/dev/null || true; \
		else \
			tar -czf $(HOME_DIR)/.dotfiles-backup/hypr.backup.tar.gz -C $(CONFIG_DIR) hypr 2>/dev/null || true; \
		fi; \
	fi
	@echo "✓ Backups created in $(HOME_DIR)/.dotfiles-backup/"

# Check if zsh is installed
check-zsh:
	@if ! command -v zsh >/dev/null 2>&1; then \
		echo "⚠ Warning: zsh is not installed. Install it first:"; \
		echo "  macOS: brew install zsh"; \
		echo "  Linux: sudo apt install zsh  # or equivalent"; \
		exit 1; \
	fi

# Check if Neovim is installed
check-nvim:
	@if ! command -v nvim >/dev/null 2>&1; then \
		echo "⚠ Warning: Neovim is not installed."; \
		echo "  Install from: https://github.com/neovim/neovim/wiki/Installing-Neovim"; \
		echo "  Continuing anyway..."; \
	fi

# Validation check
check: check-zsh check-nvim
	@echo "Checking dotfiles..."
	@for file in $(ALL_DOTFILES); do \
		if [ ! -f $(DOTFILES_DIR)/$$file ]; then \
			echo "✗ Missing: $$file"; \
		else \
			echo "✓ Found: $$file"; \
		fi; \
	done
	@for dir in $(ALL_DIRS); do \
		if [ ! -d $(DOTFILES_DIR)/$$dir ]; then \
			echo "✗ Missing directory: $$dir"; \
		else \
			echo "✓ Found directory: $$dir"; \
		fi; \
	done
	@if [ ! -d $(DOTFILES_DIR)/hypr ]; then \
		echo "✗ Missing directory: hypr"; \
	else \
		echo "✓ Found directory: hypr"; \
	fi
	@echo "✓ Validation complete"

# Install zinit (lightweight zsh plugin manager)
zinit:
	@if [ ! -d "$(HOME_DIR)/.local/share/zinit/zinit.git" ]; then \
		echo "Installing zinit..."; \
		mkdir -p $(HOME_DIR)/.local/share/zinit; \
		git clone https://github.com/zdharma-continuum/zinit.git $(HOME_DIR)/.local/share/zinit/zinit.git || true; \
		echo "✓ zinit installed"; \
	else \
		echo "✓ zinit already installed"; \
	fi

# Install git-aliases plugin (if oh-my-zsh custom plugins dir exists)
git-aliases:
	@if [ -d "$(HOME_DIR)/.oh-my-zsh/custom/plugins" ]; then \
		if [ ! -d "$(HOME_DIR)/.oh-my-zsh/custom/plugins/git-aliases" ]; then \
			echo "Installing git-aliases plugin..."; \
			git clone https://github.com/peterhurford/git-aliases.zsh.git $(HOME_DIR)/.oh-my-zsh/custom/plugins/git-aliases || true; \
			echo "✓ git-aliases installed"; \
		else \
			echo "✓ git-aliases already installed"; \
		fi; \
	fi

# Install send plugin (if oh-my-zsh custom plugins dir exists)
send-plugin:
	@if [ -d "$(HOME_DIR)/.oh-my-zsh/custom/plugins" ]; then \
		if [ ! -d "$(HOME_DIR)/.oh-my-zsh/custom/plugins/send" ]; then \
			echo "Installing send plugin..."; \
			git clone https://github.com/robertzk/send.zsh.git $(HOME_DIR)/.oh-my-zsh/custom/plugins/send || true; \
			echo "✓ send plugin installed"; \
		else \
			echo "✓ send plugin already installed"; \
		fi; \
	fi

# Link individual dotfiles (force overwrite)
$(ALL_DOTFILE_LINKS): $(HOME_DIR)/.%:
	@echo "Linking $*..."
	@if [ -f $(HOME_DIR)/.$* ] || [ -L $(HOME_DIR)/.$* ]; then \
		rm -f $(HOME_DIR)/.$*; \
	fi
	@ln -sf $(DOTFILES_DIR)/$* $(HOME_DIR)/.$*

# Link zsh directory (force overwrite)
$(HOME_DIR)/.zsh: $(DOTFILES_DIR)/zsh
	@echo "Linking zsh directory..."
	@if [ -d $(HOME_DIR)/.zsh ] || [ -L $(HOME_DIR)/.zsh ]; then \
		rm -rf $(HOME_DIR)/.zsh; \
	fi
	@ln -sf $(DOTFILES_DIR)/zsh $(HOME_DIR)/.zsh

# Link nvim directory (force overwrite)
$(ALL_NVIM_LINK): $(DOTFILES_DIR)/nvim
	@echo "Linking nvim directory..."
	@mkdir -p $(CONFIG_DIR)
	@if [ -d $(CONFIG_DIR)/nvim ] || [ -L $(CONFIG_DIR)/nvim ]; then \
		rm -rf $(CONFIG_DIR)/nvim; \
	fi
	@ln -sf $(DOTFILES_DIR)/nvim $(CONFIG_DIR)/nvim

# Link hypr directory (force overwrite)
$(ALL_HYPR_LINK): $(DOTFILES_DIR)/hypr
	@echo "Linking hypr directory..."
	@mkdir -p $(CONFIG_DIR)
	@if [ -d $(CONFIG_DIR)/hypr ] || [ -L $(CONFIG_DIR)/hypr ]; then \
		rm -rf $(CONFIG_DIR)/hypr; \
	fi
	@ln -sf $(DOTFILES_DIR)/hypr $(CONFIG_DIR)/hypr

# Link starship config (force overwrite) - optional, managed by omarchy theme
starship-config:
	@if [ -f $(DOTFILES_DIR)/.config/starship.toml ]; then \
		echo "Linking starship config..."; \
		mkdir -p $(CONFIG_DIR); \
		if [ -f $(CONFIG_DIR)/starship.toml ] || [ -L $(CONFIG_DIR)/starship.toml ]; then \
			rm -f $(CONFIG_DIR)/starship.toml; \
		fi; \
		ln -sf $(DOTFILES_DIR)/.config/starship.toml $(CONFIG_DIR)/starship.toml; \
	else \
		echo "  ⚠ Starship config not found (managed by omarchy theme), skipping..."; \
	fi

# Link Zen Browser userChrome.css
zen-browser-theme: $(DOTFILES_DIR)/omarchy/themes/rudo/zen-browser/userChrome.css
	@if [ -d "$(HOME_DIR)/.zen-browser" ]; then \
		echo "Linking Zen Browser theme..."; \
		ZEN_PROFILE=$$(find "$(HOME_DIR)/.zen-browser" -name "*.default-release" -type d 2>/dev/null | head -1); \
		if [ -n "$$ZEN_PROFILE" ]; then \
			mkdir -p "$$ZEN_PROFILE/chrome"; \
			if [ -f "$$ZEN_PROFILE/chrome/userChrome.css" ] || [ -L "$$ZEN_PROFILE/chrome/userChrome.css" ]; then \
				rm -f "$$ZEN_PROFILE/chrome/userChrome.css"; \
			fi; \
			ln -sf "$(DOTFILES_DIR)/omarchy/themes/rudo/zen-browser/userChrome.css" "$$ZEN_PROFILE/chrome/userChrome.css"; \
			echo "  ✓ Linked to $$ZEN_PROFILE/chrome/userChrome.css"; \
			echo "  ⚠ Enable custom CSS: Set toolkit.legacyUserProfileCustomizations.stylesheets=true in about:config"; \
		else \
			echo "  ⚠ Zen Browser profile not found, skipping..."; \
		fi; \
	else \
		echo "  ⚠ Zen Browser not installed, skipping theme..."; \
	fi

# Link Spicetify theme
spicetify-theme: $(DOTFILES_DIR)/omarchy/themes/rudo/spicetify
	@if command -v spicetify >/dev/null 2>&1; then \
		echo "Linking Spicetify theme..."; \
		mkdir -p "$(CONFIG_DIR)/spicetify/Themes/rudo"; \
		for file in config.ini color.ini user.css; do \
			if [ -f "$(DOTFILES_DIR)/omarchy/themes/rudo/spicetify/$$file" ]; then \
				if [ -f "$(CONFIG_DIR)/spicetify/Themes/rudo/$$file" ] || [ -L "$(CONFIG_DIR)/spicetify/Themes/rudo/$$file" ]; then \
					rm -f "$(CONFIG_DIR)/spicetify/Themes/rudo/$$file"; \
				fi; \
				ln -sf "$(DOTFILES_DIR)/omarchy/themes/rudo/spicetify/$$file" "$(CONFIG_DIR)/spicetify/Themes/rudo/$$file"; \
			fi; \
		done; \
		echo "  ✓ Spicetify theme linked"; \
		echo "  ⚠ Run: spicetify config current_theme rudo && spicetify config color_scheme rudo && spicetify apply"; \
	else \
		echo "  ⚠ Spicetify not installed, skipping theme..."; \
	fi

# Link other directories (if any) (force overwrite)
$(ALL_DIR_LINKS): $(HOME_DIR)/.%:
	@echo "Linking $* directory..."
	@if [ -d $(HOME_DIR)/.$* ] || [ -L $(HOME_DIR)/.$* ]; then \
		rm -rf $(HOME_DIR)/.$*; \
	fi
	@ln -sf $(DOTFILES_DIR)/$* $(HOME_DIR)/.$*

# Link private dotfiles (if they exist in Dropbox)
$(ALL_PRIVATE_DOTFILE_LINKS): $(HOME_DIR)/.%:
	@if [ -f "$(HOME_DIR)/Dropbox/dotfiles/$*" ]; then \
		echo "Linking private $*..."; \
		ln -sf $(HOME_DIR)/Dropbox/dotfiles/$* $(HOME_DIR)/.$*; \
	fi

# Clean targets
clean: $(ALL_CLEAN) clean-nvim clean-hypr clean-zsh clean-zen-browser clean-spicetify
	@echo "✓ Cleanup complete"

$(ALL_CLEAN): clean-%:
	@if [ -L $(HOME_DIR)/.$* ]; then \
		echo "Removing .$*"; \
		rm -f $(HOME_DIR)/.$*; \
	fi

clean-nvim:
	@if [ -L $(CONFIG_DIR)/nvim ]; then \
		echo "Removing nvim config"; \
		rm -f $(CONFIG_DIR)/nvim; \
	fi

clean-hypr:
	@if [ -L $(CONFIG_DIR)/hypr ]; then \
		echo "Removing hypr config"; \
		rm -f $(CONFIG_DIR)/hypr; \
	fi

clean-zsh:
	@if [ -L $(HOME_DIR)/.zsh ]; then \
		echo "Removing .zsh"; \
		rm -f $(HOME_DIR)/.zsh; \
	fi

clean-zen-browser:
	@if [ -d "$(HOME_DIR)/.zen-browser" ]; then \
		ZEN_PROFILE=$$(find "$(HOME_DIR)/.zen-browser" -name "*.default-release" -type d 2>/dev/null | head -1); \
		if [ -n "$$ZEN_PROFILE" ] && [ -L "$$ZEN_PROFILE/chrome/userChrome.css" ]; then \
			echo "Removing Zen Browser theme"; \
			rm -f "$$ZEN_PROFILE/chrome/userChrome.css"; \
		fi; \
	fi

clean-spicetify:
	@if [ -d "$(CONFIG_DIR)/spicetify/Themes/rudo" ]; then \
		echo "Removing Spicetify theme"; \
		rm -rf "$(CONFIG_DIR)/spicetify/Themes/rudo"; \
	fi

# Restore from backup
restore:
	@if [ -d $(HOME_DIR)/.dotfiles-backup ]; then \
		echo "Restoring from backup..."; \
		for file in $(ALL_DOTFILES); do \
			if [ -f $(HOME_DIR)/.dotfiles-backup/$$file.backup ]; then \
				echo "  Restoring .$$file"; \
				rm -f $(HOME_DIR)/.$$file; \
				cp $(HOME_DIR)/.dotfiles-backup/$$file.backup $(HOME_DIR)/.$$file; \
			fi; \
		done; \
		for file in zshrc_local bashrc_local; do \
			if [ -f $(HOME_DIR)/.dotfiles-backup/$$file.backup ]; then \
				echo "  Restoring .$$file"; \
				rm -f $(HOME_DIR)/.$$file; \
				cp $(HOME_DIR)/.dotfiles-backup/$$file.backup $(HOME_DIR)/.$$file; \
			fi; \
		done; \
		for dir in $(ALL_DIRS); do \
			if [ -f $(HOME_DIR)/.dotfiles-backup/$$dir.backup.tar.gz ]; then \
				echo "  Restoring .$$dir"; \
				rm -rf $(HOME_DIR)/.$$dir; \
				tar -xzf $(HOME_DIR)/.dotfiles-backup/$$dir.backup.tar.gz -C $(HOME_DIR); \
			fi; \
		done; \
		if [ -f $(HOME_DIR)/.dotfiles-backup/nvim.backup.tar.gz ]; then \
			echo "  Restoring nvim config"; \
			mkdir -p $(CONFIG_DIR); \
			rm -rf $(CONFIG_DIR)/nvim; \
			tar -xzf $(HOME_DIR)/.dotfiles-backup/nvim.backup.tar.gz -C $(CONFIG_DIR); \
		fi; \
		if [ -f $(HOME_DIR)/.dotfiles-backup/hypr.backup.tar.gz ]; then \
			echo "  Restoring hypr config"; \
			mkdir -p $(CONFIG_DIR); \
			rm -rf $(CONFIG_DIR)/hypr; \
			tar -xzf $(HOME_DIR)/.dotfiles-backup/hypr.backup.tar.gz -C $(CONFIG_DIR); \
		fi; \
		echo "✓ Restore complete"; \
	else \
		echo "✗ No backup found"; \
	fi
