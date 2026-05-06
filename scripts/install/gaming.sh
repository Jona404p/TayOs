#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Gaming
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_GAMING_ICON} ${PACK_GAMING_NAME}"

require_sudo
check_internet

# Habilitar arquitectura i386 para Wine/Steam
print_info "Habilitando soporte i386 para compatibilidad con juegos..."
sudo dpkg --add-architecture i386 >> "$LOG_FILE" 2>&1

# Agregar repositorio Steam si no existe
if ! apt-cache show steam &>/dev/null; then
    print_info "Agregando repositorios necesarios para Steam..."
    sudo apt-get update -qq >> "$LOG_FILE" 2>&1
fi

echo -e "  Paquetes a instalar:"
for p in "${PACK_GAMING[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Gaming?" || { echo "Cancelado."; exit 0; }

install_pack PACK_GAMING "$PACK_GAMING_NAME"
print_summary

# Configurar gamemode
if is_installed gamemode; then
    print_info "Añadiendo usuario al grupo gamemode..."
    sudo usermod -aG gamemode "$USER" >> "$LOG_FILE" 2>&1
fi

echo -e "  ${DONE} ${BOLD}${PACK_GAMING_NAME} listo.${RESET}"
echo -e "  ${DIM}  Reinicia sesión para activar gamemode.${RESET}"
