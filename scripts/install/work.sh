#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Trabajo & Oficina
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_WORK_ICON} ${PACK_WORK_NAME}"

require_sudo
check_internet

echo -e "  Paquetes a instalar:"
for p in "${PACK_WORK[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Trabajo?" || { echo "Cancelado."; exit 0; }

install_pack PACK_WORK "$PACK_WORK_NAME"
print_summary

echo -e "  ${DONE} ${BOLD}${PACK_WORK_NAME} listo.${RESET}"
