#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Ciberseguridad
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_CYBER_ICON} ${PACK_CYBER_NAME}"

require_sudo
check_internet

echo -e "  ${YELLOW}${WARN} Este pack instala herramientas de auditoría de red.${RESET}"
echo -e "  ${YELLOW}     Úsalas únicamente en redes y sistemas autorizados.${RESET}"
echo ""

echo -e "  Paquetes a instalar:"
for p in "${PACK_CYBER[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Ciberseguridad?" || { echo "Cancelado."; exit 0; }

install_pack PACK_CYBER "$PACK_CYBER_NAME"
print_summary

echo -e "  ${DONE} ${BOLD}${PACK_CYBER_NAME} lista.${RESET}"
