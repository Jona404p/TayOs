#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Sistema & Utilidades
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_SYS_ICON} ${PACK_SYS_NAME}"

require_sudo
check_internet

echo -e "  Paquetes a instalar:"
for p in "${PACK_SYS[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Sistema?" || { echo "Cancelado."; exit 0; }

install_pack PACK_SYS "$PACK_SYS_NAME"
print_summary

echo -e "  ${DONE} ${BOLD}${PACK_SYS_NAME} listo.${RESET}"
