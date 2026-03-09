#!/usr/bin/env bash

set -e

TARGET_DIR="$HOME/.config/fastfetch"
FONT_DIR="$HOME/.local/share/fonts"
CONFIG_URL="https://raw.githubusercontent.com/Lynxz411/Lynxz-fastfetch/main/config.jsonc"

echo "======================================"
echo "⚡ Installing Fastfetch theme..."
echo "======================================"

# -----------------------------
# Detect distro
# -----------------------------
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "❌ Cannot detect distro"
    exit 1
fi

echo "Detected distro: $DISTRO"

# -----------------------------
# Install dependencies
# -----------------------------
install_deps() {

case "$DISTRO" in

arch)
sudo pacman -Sy --needed curl unzip fontconfig fastfetch
;;

ubuntu|debian)
sudo apt update
sudo apt install -y curl unzip fontconfig fastfetch
;;

fedora)
sudo dnf install -y curl unzip fontconfig fastfetch
;;

*)
echo "⚠ Unsupported distro. Install fastfetch manually."
;;

esac

}

# -----------------------------
# Install fastfetch if missing
# -----------------------------
if ! command -v fastfetch &> /dev/null; then

echo "⚠ fastfetch not found. Installing..."
install_deps
echo "✔ fastfetch installed"

else

echo "✔ fastfetch already installed"

fi

echo ""

# -----------------------------
# Detect shell
# -----------------------------
CURRENT_SHELL=$(basename "$SHELL")

if [ "$CURRENT_SHELL" = "bash" ]; then
    RC_FILE="$HOME/.bashrc"
elif [ "$CURRENT_SHELL" = "zsh" ]; then
    RC_FILE="$HOME/.zshrc"
elif [ "$CURRENT_SHELL" = "fish" ]; then
    RC_FILE="$HOME/.config/fish/config.fish"
    mkdir -p "$HOME/.config/fish"
else
    echo "Unsupported shell: $CURRENT_SHELL"
    exit 1
fi

echo "Detected shell: $CURRENT_SHELL"

# -----------------------------
# Check fastfetch
# -----------------------------
if ! command -v fastfetch &> /dev/null; then
    echo "❌ Fastfetch is not installed."
    echo "Install it first then re-run this script."
    exit 1
fi

# -----------------------------
# Install config
# -----------------------------
mkdir -p "$TARGET_DIR"

if [ -f "$TARGET_DIR/config.jsonc" ]; then
    mv "$TARGET_DIR/config.jsonc" "$TARGET_DIR/config.jsonc.bak.$(date +%s)"
fi

echo "Downloading config.jsonc from GitHub..."
curl -fsSL "$CONFIG_URL" -o "$TARGET_DIR/config.jsonc"

echo "✔ Config installed."

# -----------------------------
# Inject fastfetch to shell rc
# -----------------------------
if ! grep -q "fastfetch" "$RC_FILE" 2>/dev/null; then
    echo "" >> "$RC_FILE"
    echo "# Lynxz Fastfetch" >> "$RC_FILE"
    echo "fastfetch" >> "$RC_FILE"
    echo "✔ fastfetch added to $RC_FILE"
else
    echo "fastfetch already in $RC_FILE"
fi

# -----------------------------
# Install JetBrainsMono Nerd Font 
# -----------------------------
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
fi

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    echo "🧠 Installing JetBrainsMono Nerd Font..."

    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    curl -fLo "JetBrainsMono.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

    unzip JetBrainsMono.zip
    cp *.ttf "$FONT_DIR/"
    fc-cache -fv

    cd -
    rm -rf "$TMP_DIR"

    echo "✔ Font installed."
else
    echo "JetBrainsMono Nerd Font already installed."
fi

echo
echo "Fastfetch theme installed successfully!"
echo "💡 Note: Don't forget to edit ~/.config/fastfetch/config.jsonc to set your own profile picture!"
echo "Restart terminal or run: source $RC_FILE"
