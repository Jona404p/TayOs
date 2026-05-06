#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Internet & Comunicación
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_NET_ICON} ${PACK_NET_NAME}"

require_sudo
check_internet

echo -e "  Paquetes a instalar:"
for p in "${PACK_NET[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Internet?" || { echo "Cancelado."; exit 0; }

install_pack PACK_NET "$PACK_NET_NAME"
print_summary

echo -e "  ${DONE} ${BOLD}${PACK_NET_NAME} listo.${RESET}"
