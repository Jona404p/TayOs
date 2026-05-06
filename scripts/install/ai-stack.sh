#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Pack: IA & Machine Learning
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../core/utils.sh"
source "$SCRIPT_DIR/../config/packs.sh"

print_banner
print_section "${PACK_AI_ICON} ${PACK_AI_NAME}"

require_sudo
check_internet

# Mostrar espacio requerido (aprox)
echo -e "  ${WARN} Los modelos de IA requieren varios GB de espacio."
echo ""
local_free=$(df -BG / | awk 'NR==2{print $4}' | tr -d 'G')
echo -e "  Espacio libre: ${BOLD}${local_free}GB${RESET}"
if [[ "$local_free" -lt 10 ]]; then
    print_warn "Se recomiendan al menos 10 GB libres."
fi
echo ""

echo -e "  Dependencias APT:"
for p in "${PACK_AI_APT[@]}"; do
    echo -e "  ${DIM}  • $p${RESET}"
done
echo ""
echo -e "  Modelos Ollama:"
for m in "${PACK_AI_MODELS[@]}"; do
    echo -e "  ${DIM}  • $m${RESET}"
done
echo ""

confirm "¿Instalar el IA Stack?" || { echo "Cancelado."; exit 0; }

# ── Instalar dependencias APT ─────────────────────────────────────
install_pack PACK_AI_APT "Dependencias IA"

# ── Instalar Ollama ───────────────────────────────────────────────
print_section "🦙 Instalando Ollama"

if command -v ollama &>/dev/null; then
    OLLAMA_VER=$(ollama --version 2>/dev/null | awk '{print $NF}')
    print_ok "Ollama ya instalado (versión: $OLLAMA_VER)"
else
    print_info "Descargando e instalando Ollama..."
    if curl -fsSL https://ollama.com/install.sh | sh >> "$LOG_FILE" 2>&1; then
        print_ok "Ollama instalado"
    else
        print_fail "No se pudo instalar Ollama"
        exit 1
    fi
fi

# Iniciar servicio Ollama
sudo systemctl enable --now ollama >> "$LOG_FILE" 2>&1 || true
sleep 2

# ── Descargar modelos ─────────────────────────────────────────────
print_section "📥 Descargando modelos"

for model in "${PACK_AI_MODELS[@]}"; do
    echo -ne "  ${PKG_ICON} Descargando ${BOLD}$model${RESET}..."
    if ollama pull "$model" >> "$LOG_FILE" 2>&1; then
        echo -e "\r  ${GREEN}${OK} $model descargado${RESET}           "
    else
        echo -e "\r  ${YELLOW}${WARN} $model no pudo descargarse${RESET}"
    fi
done

print_summary
echo -e "  ${DONE} ${BOLD}IA Stack listo.${RESET}"
echo -e "  ${DIM}  Prueba: ${CYAN}ollama run llama3.2:3b${RESET}"
