#!/bin/bash

set -e

TARGET_DIR="$HOME/.config/fastfetch"
FONT_DIR="$HOME/.local/share/fonts"

echo "======================================"
echo "🗑️  Uninstalling Lynxz Fastfetch..."
echo "======================================"
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
        ;;
    *)
        echo "⚠️  Unsupported shell: $CURRENT_SHELL"
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
                CURRENT_SHELL="fish"
                ;;
            *)
                echo "❌ Invalid shell choice. Exiting."
                exit 1
                ;;
        esac
        ;;
esac

echo "✔️  Detected shell: $CURRENT_SHELL"
echo ""

# -----------------------------
# Remove Fastfetch configuration
# -----------------------------
if [ -d "$TARGET_DIR" ]; then
    echo "📂 Removing Fastfetch configuration..."
    rm -rf "$TARGET_DIR"
    echo "✔️  Configuration removed from $TARGET_DIR"
else
    echo "⚠️  Configuration directory not found at $TARGET_DIR"
fi

echo ""

# -----------------------------
# Remove shell injection
# -----------------------------
if [ -f "$RC_FILE" ]; then
    echo "🔍 Removing fastfetch injection from shell RC..."
    
    # Create backup before modifying
    cp "$RC_FILE" "$RC_FILE.bak.$(date +%s)"
    
    # Remove Lynxz Fastfetch section
    if grep -q "# Lynxz Fastfetch" "$RC_FILE" 2>/dev/null; then
        # Use sed to remove the comment and fastfetch line
        sed -i '/# Lynxz Fastfetch/d' "$RC_FILE"
        sed -i '/^fastfetch$/d' "$RC_FILE"
        # Also remove any empty lines left behind
        sed -i '/^[[:space:]]*$/d; N; s/^\n$//; P; D' "$RC_FILE" 2>/dev/null || true
        echo "✔️  Removed fastfetch from $RC_FILE"
    else
        echo "ℹ️  No Lynxz Fastfetch injection found in $RC_FILE"
    fi
else
    echo "⚠️  Shell config file not found at $RC_FILE"
fi

echo ""

# -----------------------------
# Ask about removing fonts
# -----------------------------
echo "🧠 JetBrainsMono Nerd Font is installed but NOT removed by default"
echo "   (to avoid breaking other applications that may use it)"
echo ""
read -p "Would you like to remove JetBrainsMono Nerd Font? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🗑️  Removing JetBrainsMono Nerd Font..."
    
    if [ -d "$FONT_DIR" ]; then
        # Remove JetBrainsMono font files
        rm -f "$FONT_DIR"/JetBrainsMono*.ttf 2>/dev/null || true
        
        # Rebuild font cache
        if command -v fc-cache &> /dev/null; then
            fc-cache -fv > /dev/null 2>&1 || true
            echo "✔️  Font cache rebuilt"
        fi
        
        echo "✔️  JetBrainsMono Nerd Font removed"
    else
        echo "⚠️  Font directory not found at $FONT_DIR"
    fi
else
    echo "ℹ️  Keeping JetBrainsMono Nerd Font"
fi

echo ""
echo "======================================"
echo "✅ Uninstallation complete!"
echo "======================================"
echo ""
echo "📋 Summary:"
echo "   ✔️  Fastfetch config removed from ~/.config/fastfetch"
echo "   ✔️  Shell integration removed from $RC_FILE"
echo "   $([ -d "$FONT_DIR" ] && echo "✔️  Font$(grep -q JetBrainsMono "$FONT_DIR"/* 2>/dev/null && echo " was" || echo " was not") removed" || echo "⚠️  Font directory not found")"
echo ""
echo "🙏 Thank you for using Lynxz Fastfetch!"
echo "   Feel free to reach out with feedback: https://github.com/Lynxz411/Lynxz-fastfetch"
echo ""
