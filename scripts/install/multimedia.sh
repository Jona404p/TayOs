#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: Multimedia
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_MEDIA_ICON} ${PACK_MEDIA_NAME}"

require_sudo
check_internet

# Spotify requiere repositorio externo
if ! apt-cache show spotify-client &>/dev/null 2>&1; then
    print_info "Agregando repositorio de Spotify..."
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg \
        | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg >> "$LOG_FILE" 2>&1
    echo "deb http://repository.spotify.com stable non-free" \
        | sudo tee /etc/apt/sources.list.d/spotify.list >> "$LOG_FILE" 2>&1
fi

echo -e "  Paquetes a instalar:"
for p in "${PACK_MEDIA[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""

confirm "¿Instalar el pack de Multimedia?" || { echo "Cancelado."; exit 0; }

install_pack PACK_MEDIA "$PACK_MEDIA_NAME"
print_summary

echo -e "  ${DONE} ${BOLD}${PACK_MEDIA_NAME} listo.${RESET}"
