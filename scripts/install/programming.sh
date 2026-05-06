#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Programación & Dev
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_DEV_ICON} ${PACK_DEV_NAME}"

require_sudo
check_internet

echo -e "  Paquetes a instalar:"
for p in "${PACK_DEV[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Programación?" || { echo "Cancelado."; exit 0; }

install_pack PACK_DEV "$PACK_DEV_NAME"

# VS Code (si no está instalado via apt como 'code')
if ! command -v code &>/dev/null; then
    print_info "Instalando Visual Studio Code..."
    wget -qO /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" >> "$LOG_FILE" 2>&1 \
        && sudo dpkg -i /tmp/vscode.deb >> "$LOG_FILE" 2>&1 \
        && rm /tmp/vscode.deb \
        && print_ok "VS Code instalado" \
        || print_warn "VS Code no pudo instalarse, instálalo manualmente desde code.visualstudio.com"
fi

# Docker post-install
if is_installed docker.io; then
    print_info "Configurando Docker para usuario actual..."
    sudo usermod -aG docker "$USER" >> "$LOG_FILE" 2>&1
    sudo systemctl enable --now docker >> "$LOG_FILE" 2>&1
    print_ok "Docker listo (reinicia sesión para usarlo sin sudo)"
fi

print_summary
echo -e "  ${DONE} ${BOLD}${PACK_DEV_NAME} listo.${RESET}"
