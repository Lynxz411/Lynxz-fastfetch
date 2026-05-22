# 🚀 Lynxz Fastfetch

> Custom Fastfetch configuration with boxed layout & OS age module

<div align="center">

[![Bash](https://img.shields.io/badge/Bash-5.0+-brightgreen?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
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
- 🐚 **Multi-shell support** - Bash, Zsh, Fish
- 🛡️ **Robust installation** - auto-detect distro & dependencies
- 📦 **Easy uninstall** - clean removal of all components

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

| Component | Purpose |
|-----------|---------|
| **Fastfetch** | System information display |
| **Nerd Font** | Beautiful icons & glyphs |
| **Kitty Terminal** | Image logo display *(optional)* |
| **curl** | Download configuration files |
| **unzip** | Extract font files |
| **fontconfig** | Font management |

### Supported Distros
- ✅ **Arch Linux** (pacman)
- ✅ **Manjaro** (pacman)
- ✅ **CachyOS** (pacman)
- ✅ **Ubuntu/Debian** (apt)
- ✅ **Fedora** (dnf)

---

## 🛠️ Configuration

After installation, customize your config:

```bash
nano ~/.config/fastfetch/config.jsonc
```

Common customizations:
- **Profile picture** - Set your own image path in `imageSource`
- **Colors** - Adjust color scheme in `colors` section
- **Modules** - Enable/disable info modules (CPU, GPU, Memory, etc.)

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

### What gets removed:
- ❌ Fastfetch configuration from `~/.config/fastfetch/config.jsonc`
- ❌ Shell integration (fastfetch command from `.bashrc`/`.zshrc`/`config.fish`)
- ❌ JetBrainsMono Nerd Font *(optional during uninstall)*

---

## 📁 Directory Structure

```
Lynxz-fastfetch/
├── install.sh          # Installation script
├── uninstall.sh        # Uninstallation script
├── config.jsonc        # Fastfetch configuration
├── image.png           # Preview screenshot
└── README.md           # This file
```

---

## ⚙️ Installation Details

### What the installer does:
1. ✅ Detects your Linux distro
2. ✅ Installs required dependencies
3. ✅ Detects your shell (Bash, Zsh, Fish)
4. ✅ Downloads Fastfetch configuration
5. ✅ Injects fastfetch into shell RC file
6. ✅ Installs JetBrainsMono Nerd Font

### What the uninstaller does:
1. ✅ Removes Fastfetch configuration backup
2. ✅ Removes fastfetch from shell RC files
3. ✅ Optionally removes JetBrainsMono Nerd Font
4. ✅ Cleans up installation traces

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
```

### Permission denied when running script
```bash
# Make scripts executable
chmod +x install.sh uninstall.sh
```

---

## 📝 Configuration File Location

The configuration is stored at:
```
~/.config/fastfetch/config.jsonc
```

A backup is automatically created during updates:
```
~/.config/fastfetch/config.jsonc.bak.<timestamp>
```

---

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Credits

- **Fastfetch** - System information tool
- **Nerd Fonts** - Font collection with icons
- **Lynxz** - Custom configuration & scripts

---

<div align="center">

**Made with ❤️ by [Lynxz](https://github.com/Lynxz411)**

⭐ If you like this project, please give it a star!

</div>
