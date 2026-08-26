# 🚀 Lynxz Fastfetch

> Custom Fastfetch configuration with boxed layout & OS age module + integrated Kitty & Fish shell setup

<div align="center">

[![Bash](https://img.shields.io/badge/Bash-5.0+-brightgreen?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Kitty](https://img.shields.io/badge/Kitty-Terminal-orange?logo=windows-terminal&logoColor=white)](https://sw.kovidgoyal.net/kitty/)
[![Fish](https://img.shields.io/badge/Fish-Shell-blue?logo=linux&logoColor=white)](https://fishshell.com)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Lynxz411/Lynxz-fastfetch?style=social)](https://github.com/Lynxz411/Lynxz-fastfetch)

</div>

---

## 📸 Preview

<img src="image.png" alt="Fastfetch Preview" width="600"/>

---

## ✨ Features

- 🎨 **Aesthetic boxed layout** with rounded borders
- 🔤 **Nerd Font icons** for beautiful UI
- 📅 **OS Age counter** - displays how long your OS has been installed
- 🖼️ **Kitty image logo** - terminal image support
- 🐚 **Multi-shell support** - Bash, Zsh, Fish with individual configs
- 🐱 **Kitty Terminal** - Automatic terminal configuration
- 🛡️ **Robust installation** - auto-detect distro & dependencies
- 📦 **Easy uninstall** - clean removal of all components
- 🚀 **Auto-configuration** - Kitty and Fish shell auto-setup

---

## 🚀 Quick Start

### One-liner Installation
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Lynxz411/Lynxz-fastfetch/main/install.sh)"
```

### Manual Installation
```bash
git clone https://github.com/Lynxz411/Lynxz-fastfetch.git
cd Lynxz-fastfetch
chmod +x install.sh
./install.sh
```

---

## 📋 Requirements

| Component | Purpose | Auto-Install |
|-----------|---------|:--------------:|
| **Fastfetch** | System information display | ✅ Yes |
| **Nerd Font** | Beautiful icons & glyphs | ✅ Yes |
| **Kitty Terminal** | Terminal config *(optional)* | ✅ Auto-setup |
| **Fish Shell** | Shell config *(optional)* | ✅ Auto-setup |
| **curl** | Download configuration files | ✅ Yes |
| **unzip** | Extract font files | ✅ Yes |
| **fontconfig** | Font management | ✅ Yes |

### Supported Distros
- ✅ **Arch Linux** (pacman)
- ✅ **Manjaro** (pacman)
- ✅ **CachyOS** (pacman)
- ✅ **Ubuntu/Debian** (apt)
- ✅ **Fedora** (dnf)

---

## 🛠️ Installation Details

### What the installer does:
1. ✅ Detects your Linux distro
2. ✅ Installs required dependencies
3. ✅ Detects your shell (Bash, Zsh, Fish)
4. ✅ Downloads Fastfetch configuration
5. ✅ Injects fastfetch into shell RC file
6. ✅ Auto-configures Fish shell (if using Fish)
7. ✅ Auto-configures Kitty terminal (if installed)
8. ✅ Installs JetBrainsMono Nerd Font

### What Gets Installed

- `~/.config/fastfetch/config.jsonc` - Fastfetch configuration
- `~/.bashrc` / `~/.zshrc` / `~/.config/fish/config.fish` - Shell initialization
- `~/.config/kitty/kitty.conf` - Kitty terminal configuration (if Kitty is installed)
- `~/.local/share/fonts/` - JetBrainsMono Nerd Font

---

## ⚙️ Configuration

### Fastfetch Configuration
The configuration is stored at:
```
~/.config/fastfetch/config.jsonc
```

After installation, customize your config:
```bash
nano ~/.config/fastfetch/config.jsonc
```

Common customizations:
- **Profile picture** - Set your own image path in `imageSource`
- **Colors** - Adjust color scheme in `colors` section
- **Modules** - Enable/disable info modules (CPU, GPU, Memory, etc.)

### Fish Shell Configuration
If using Fish shell, the config is at:
```
~/.config/fish/config.fish
```

Includes:
- Shell aliases (clear, celar, claer, pamcan, q, ls, ssh)
- Fastfetch integration
- Kitty SSH kitten support

### Kitty Terminal Configuration
If Kitty is installed, the config is at:
```
~/.config/kitty/kitty.conf
```

Includes:
- Font: JetBrains Mono Nerd Font
- Font size: 12.0
- Cursor styling
- Keyboard shortcuts
- Search and zoom bindings
- Background opacity

---

## 🗑️ Uninstallation

Remove all Lynxz Fastfetch components:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Lynxz411/Lynxz-fastfetch/main/uninstall.sh)"
```

Or manually:
```bash
cd Lynxz-fastfetch
chmod +x uninstall.sh
./uninstall.sh
```

### What the uninstaller does:
1. ✅ Removes Fastfetch configuration
2. ✅ Removes fastfetch from shell RC files
3. ✅ Removes Kitty configuration (if it's default template)
4. ✅ Optionally removes JetBrainsMono Nerd Font
5. ✅ Cleans up installation traces
6. ✅ Creates backups with timestamp

### What gets removed:
- ❌ Fastfetch configuration from `~/.config/fastfetch/config.jsonc`
- ❌ Shell integration (fastfetch command from `.bashrc`/`.zshrc`/`config.fish`)
- ❌ Kitty configuration (if default template)
- ❌ JetBrainsMono Nerd Font *(optional during uninstall)*
- 💾 Config backups saved to `*.bak.<timestamp>`

---

## 📁 Directory Structure

```
Lynxz-fastfetch/
├── install.sh          # Installation script
├── uninstall.sh        # Uninstallation script
├── config.jsonc        # Fastfetch configuration
├── kitty.conf          # Kitty terminal template
├── config.fish         # Fish shell template
├── image.png           # Preview screenshot
├── README.md           # This file
└── LICENSE             # MIT License
```

---

## 🔧 Troubleshooting

### Fastfetch not running on shell startup
```bash
# Manually source your shell config
source ~/.bashrc   # for bash
# or
source ~/.zshrc    # for zsh
```

### Font not displaying correctly
```bash
# Rebuild font cache
fc-cache -fv

# Check if font is installed
fc-list | grep -i jetbrains
```

### Permission denied when running script
```bash
# Make scripts executable
chmod +x install.sh uninstall.sh
```

### Kitty terminal not using new config
```bash
# Restart Kitty terminal completely
# Or reload config with Ctrl+Shift+F5 (if enabled in kitty.conf)
```

### Fish shell configuration not loading
```bash
# Check Fish config syntax
fish -n ~/.config/fish/config.fish

# View current config
cat ~/.config/fish/config.fish

# Reload Fish (from Fish shell)
source ~/.config/fish/config.fish
```

---

## 📝 Configuration File Locations

All configuration files are stored in your home directory:

```
~/.config/fastfetch/config.jsonc    # Fastfetch config
~/.config/fish/config.fish          # Fish shell config (if using Fish)
~/.config/kitty/kitty.conf          # Kitty terminal config (if installed)
```

Backups are automatically created during updates:
```
~/.config/fastfetch/config.jsonc.bak.<timestamp>
~/.config/fish/config.fish.bak.<timestamp>
~/.config/kitty/kitty.conf.bak.<timestamp>
```

---

## 🤝 Integration Tips

### Kitty Terminal + Fastfetch
The installer automatically configures Kitty with:
```bash
# Font configuration
font_family JetBrains Mono Nerd Font
font_size 12.0

# Cursor and behavior settings
cursor_shape beam
cursor_trail 1
confirm_os_window_close 0
```

### Fish Shell Specific
```bash
# Aliases are pre-configured:
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias ls 'eza --icons=auto'

# SSH Kitten support for Kitty is included
alias ssh 'kitten ssh'

# Use abbreviations for custom commands
abbr -a ll 'ls -la'
abbr -a gs 'git status'
```

### SSH Sessions
```bash
# Fastfetch works over SSH
# Make sure Fastfetch is installed on remote
# And nerd fonts are available locally
```

---

## 💡 Tips & Tricks

### Backup your config before editing
```bash
cp ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.backup
```

### Test Fastfetch directly
```bash
fastfetch
```

### Speed up shell startup
```bash
# If startup is slow, check what's taking time
time bash -i -c echo  # Bash
time zsh -i -c echo   # Zsh
```

### Restore from backup
```bash
# If something went wrong, restore from backup
mv ~/.config/fastfetch/config.jsonc.bak.* ~/.config/fastfetch/config.jsonc  # Latest backup
```

---

## 📚 Resources

- 🌐 [Fastfetch Documentation](https://github.com/LinusDierks/fastfetch)
- 🔤 [Nerd Fonts](https://www.nerdfonts.com)
- 🐱 [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- 🐚 [Fish Shell](https://fishshell.com)

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Credits

- **Fastfetch** - System information tool
- **Nerd Fonts** - Font collection with icons
- **Kitty Terminal** - GPU-based terminal emulator
- **Fish Shell** - User-friendly shell
- **Lynxz** - Custom configuration & scripts

---

<div align="center">

**Made with ❤️ by [Lynxz](https://github.com/Lynxz411)**

⭐ If you like this project, please give it a star!

[Report Issue](https://github.com/Lynxz411/Lynxz-fastfetch/issues) • [Request Feature](https://github.com/Lynxz411/Lynxz-fastfetch/issues/new)

</div>
