#!/bin/bash

set -e

TARGET_DIR="$HOME/.config/fastfetch"
FONT_DIR="$HOME/.local/share/fonts"
CONFIG_URL="https://raw.githubusercontent.com/Lynxz411/Lynxz-fastfetch/main/config.jsonc"
REPO_RAW_BASE="https://raw.githubusercontent.com/Lynxz411/Lynxz-fastfetch/main"

echo "======================================"
echo "⚡ Installing Fastfetch theme..."
echo "======================================"

# -----------------------------
# Detect Distro
# -----------------------------
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    echo "Detected distro: $DISTRO"
else
    echo "❌ Cannot detect Linux distro."
    exit 1
fi

# -----------------------------
# Install dependencies
# -----------------------------
install_deps() {
    case "$DISTRO" in
        arch|cachyos|manjaro)
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

# Fallback to bash if shell detection fails
if [ -z "$CURRENT_SHELL" ]; then
    CURRENT_SHELL="bash"
fi

case "$CURRENT_SHELL" in
    bash)
        RC_FILE="$HOME/.bashrc"
        ;;
    zsh)
        RC_FILE="$HOME/.zshrc"
        ;;
    fish)
        RC_FILE="$HOME/.config/fish/config.fish"
        mkdir -p "$HOME/.config/fish"
        ;;
    *)
        echo "⚠ Unsupported shell: $CURRENT_SHELL"
        echo "📝 Please specify your shell (bash/zsh/fish):"
        read -r SHELL_CHOICE
        case "$SHELL_CHOICE" in
            bash)
                RC_FILE="$HOME/.bashrc"
                CURRENT_SHELL="bash"
                ;;
            zsh)
                RC_FILE="$HOME/.zshrc"
                CURRENT_SHELL="zsh"
                ;;
            fish)
                RC_FILE="$HOME/.config/fish/config.fish"
                mkdir -p "$HOME/.config/fish"
                CURRENT_SHELL="fish"
                ;;
            *)
                echo "❌ Invalid shell choice. Exiting."
                exit 1
                ;;
        esac
        ;;
esac

echo "✔ Detected shell: $CURRENT_SHELL"

# Ensure RC file exists
if [ ! -f "$RC_FILE" ]; then
    touch "$RC_FILE"
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
    echo "✔ fastfetch already in $RC_FILE"
fi

echo ""

# -----------------------------
# Configure Fish Shell (if using Fish)
# -----------------------------
if [ "$CURRENT_SHELL" = "fish" ]; then
    echo "🐠 Configuring Fish shell..."
    
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    mkdir -p "$HOME/.config/fish"
    touch "$FISH_CONFIG"
    
    # Backup existing config if present
    if [ -s "$FISH_CONFIG" ]; then
        echo "💾 Backing up existing Fish config..."
        cp "$FISH_CONFIG" "$FISH_CONFIG.bak.$(date +%s)"
    fi
    
    # Download and apply config.fish
    echo "🔧 Setting up Fish configuration..."
    curl -fsSL "$REPO_RAW_BASE/config.fish" -o "$FISH_CONFIG"
    
    # Replace placeholder user path with actual user (if needed)
    sed -i "s|/home/lynxz|$HOME|g" "$FISH_CONFIG"
    
    echo "✔ Fish config installed to $FISH_CONFIG"
    echo ""
fi

# -----------------------------
# Configure Kitty Terminal (if installed)
# -----------------------------
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

if command -v kitty &> /dev/null; then
    echo "🐱 Configuring Kitty terminal..."
    
    mkdir -p "$HOME/.config/kitty"
    
    # Backup existing config if present
    if [ -f "$KITTY_CONFIG" ]; then
        echo "💾 Backing up existing Kitty config..."
        cp "$KITTY_CONFIG" "$KITTY_CONFIG.bak.$(date +%s)"
    fi
    
    # Download and apply kitty.conf
    echo "🔧 Setting up Kitty configuration..."
    curl -fsSL "$REPO_RAW_BASE/kitty.conf" -o "$KITTY_CONFIG"
    
    echo "✔ Kitty config installed to $KITTY_CONFIG"
    echo ""
else
    echo "ℹ️  Kitty not detected (optional)."
fi

echo ""

# -----------------------------
# Install JetBrainsMono Nerd Font 
# -----------------------------
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
fi

if ! fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
    echo "🧠 Installing JetBrainsMono Nerd Font..."

    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR" || exit 1

    curl -fLo "JetBrainsMono.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

    unzip -q JetBrainsMono.zip
    cp *.ttf "$FONT_DIR/" 2>/dev/null || true
    fc-cache -fv > /dev/null 2>&1 || true

    cd - > /dev/null || exit 1
    rm -rf "$TMP_DIR"

    echo "✔ Font installed."
else
    echo "✔ JetBrainsMono Nerd Font already installed."
fi

echo
echo "🎉 Fastfetch theme installed successfully!"
echo "💡 Note: Don't forget to edit ~/.config/fastfetch/config.jsonc to set your own profile picture!"
echo "Restart terminal or run: source $RC_FILE"
