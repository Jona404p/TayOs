#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Setup inicial
#  Ejecutar después de clonar el repo
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🌸 TayOs Software Center — Setup-JonathanP"
echo ""

# Dar permisos de ejecución a todo
chmod +x "$SCRIPT_DIR/scripts/menu.sh"
chmod +x "$SCRIPT_DIR/scripts/install/"*.sh
chmod +x "$SCRIPT_DIR/scripts/core/"*.sh
chmod +x "$SCRIPT_DIR/scripts/config/"*.sh 2>/dev/null || true

echo "✅ Permisos configurados."

# Crear alias opcional
echo ""
echo -n "¿Crear alias 'tayos-center' en tu shell? [s/N]: "
read -r ans
if [[ "$ans" =~ ^[sS]$ ]]; then
    ALIAS_LINE="alias tayos-center='bash $SCRIPT_DIR/scripts/menu.sh'"
    SHELL_RC="$HOME/.bashrc"
    [[ "$SHELL" == *"zsh"* ]] && SHELL_RC="$HOME/.zshrc"

    if ! grep -q "tayos-center" "$SHELL_RC"; then
        echo "" >> "$SHELL_RC"
        echo "# TayOs Software Center" >> "$SHELL_RC"
        echo "$ALIAS_LINE" >> "$SHELL_RC"
        echo "✅ Alias agregado en $SHELL_RC"
        echo "   Recarga tu terminal o ejecuta: source $SHELL_RC"
    else
        echo "ℹ️  El alias ya existe en $SHELL_RC"
    fi
fi

echo ""
echo "🚀 Listo. Ejecuta: bash scripts/menu.sh"
