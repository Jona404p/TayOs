#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Core Utils
#  Versión: 2.0
# ══════════════════════════════════════════════════════════════════

# ── Colores ───────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ── Iconos ────────────────────────────────────────────────────────
OK="✅"
FAIL="❌"
INFO="ℹ️ "
WARN="⚠️ "
ARROW="➜"
PKG_ICON="📦"
DONE="🎉"

# ── Variables globales de estado ──────────────────────────────────
INSTALLED_COUNT=0
FAILED_COUNT=0
FAILED_PKGS=()
LOG_FILE="${LOG_FILE:-/tmp/tayos-center.log}"
QUIET_MODE="${QUIET_MODE:-false}"
DRY_RUN="${DRY_RUN:-false}"

# ── Logger ────────────────────────────────────────────────────────
_log() {
    local level="$1"; shift
    local msg="$*"
    local ts
    ts=$(date '+%H:%M:%S')
    echo "[$ts] [$level] $msg" >> "$LOG_FILE"
}

log_info()  { _log "INFO"  "$*"; }
log_ok()    { _log "OK"    "$*"; }
log_warn()  { _log "WARN"  "$*"; }
log_error() { _log "ERROR" "$*"; }

# ── Salida con formato ────────────────────────────────────────────
print_ok()   { echo -e "${GREEN}${OK}  $*${RESET}";   log_ok   "$*"; }
print_fail() { echo -e "${RED}${FAIL}  $*${RESET}";   log_error "$*"; }
print_info() { echo -e "${CYAN}${INFO} $*${RESET}";   log_info  "$*"; }
print_warn() { echo -e "${YELLOW}${WARN} $*${RESET}"; log_warn  "$*"; }

# ── Banner principal ──────────────────────────────────────────────
print_banner() {
    clear
    echo -e "${MAGENTA}${BOLD}"
    echo "  ╔══════════════════════════════════════════╗"
    echo "  ║        🌸  TayOs Software Center         ║"
    echo "  ║          Gestor de paquetes v2.0         ║"
    echo "  ╚══════════════════════════════════════════╝"
    echo -e "${RESET}"
}

# ── Separador de sección ──────────────────────────────────────────
print_section() {
    local title="$1"
    echo ""
    echo -e "${CYAN}${BOLD}  ── $title ──${RESET}"
    echo ""
}

# ── Barra de progreso ─────────────────────────────────────────────
progress_bar() {
    local current=$1
    local total=$2
    local width=30
    local filled=$(( current * width / total ))
    local empty=$(( width - filled ))
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    printf "\r  ${CYAN}[%s]${RESET} %d/%d" "$bar" "$current" "$total"
}

# ── Verificar si un paquete está instalado ────────────────────────
is_installed() {
    dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"
}

# ── Instalar un paquete individual ───────────────────────────────
install_pkg() {
    local pkg="$1"
    local label="${2:-$pkg}"

    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "[DRY-RUN] Instalaría: $label"
        return 0
    fi

    if is_installed "$pkg"; then
        echo -e "  ${DIM}${OK} $label — ya instalado${RESET}"
        log_info "$pkg ya estaba instalado"
        (( INSTALLED_COUNT++ ))
        return 0
    fi

    echo -ne "  ${PKG_ICON} Instalando ${BOLD}$label${RESET}..."

    if sudo apt-get install -y "$pkg" >> "$LOG_FILE" 2>&1; then
        echo -e "\r  ${GREEN}${OK} $label instalado correctamente${RESET}   "
        log_ok "$pkg instalado"
        (( INSTALLED_COUNT++ ))
    else
        echo -e "\r  ${RED}${FAIL} $label — falló la instalación${RESET}   "
        log_error "$pkg falló"
        (( FAILED_COUNT++ ))
        FAILED_PKGS+=("$pkg")
    fi
}

# ── Instalar lista de paquetes con progreso ───────────────────────
install_pack() {
    local -n _pkgs=$1          # nameref al array de paquetes
    local pack_name="${2:-Pack}"
    local total=${#_pkgs[@]}
    local idx=0

    print_info "Actualizando lista de paquetes..."
    sudo apt-get update -qq >> "$LOG_FILE" 2>&1

    echo ""
    echo -e "  ${BOLD}Instalando $total paquete(s) del pack: $pack_name${RESET}"
    echo ""

    for pkg in "${_pkgs[@]}"; do
        (( idx++ ))
        progress_bar "$idx" "$total"
        install_pkg "$pkg"
    done

    echo ""
}

# ── Resumen final ─────────────────────────────────────────────────
print_summary() {
    echo ""
    echo -e "${BOLD}  ══ Resumen ══${RESET}"
    echo -e "  ${GREEN}${OK}  Instalados : $INSTALLED_COUNT${RESET}"
    if [[ $FAILED_COUNT -gt 0 ]]; then
        echo -e "  ${RED}${FAIL}  Fallidos   : $FAILED_COUNT${RESET}"
        echo -e "  ${YELLOW}     Paquetes con error:${RESET}"
        for p in "${FAILED_PKGS[@]}"; do
            echo -e "  ${RED}     • $p${RESET}"
        done
    fi
    echo ""
    echo -e "  ${DIM}Log guardado en: $LOG_FILE${RESET}"
    echo ""
}

# ── Confirmación interactiva ──────────────────────────────────────
confirm() {
    local prompt="${1:-¿Continuar?}"
    echo -ne "  ${YELLOW}${prompt} [s/N]: ${RESET}"
    read -r ans
    [[ "$ans" =~ ^[sS]$ ]]
}

# ── Requiere sudo ─────────────────────────────────────────────────
require_sudo() {
    if ! sudo -v &>/dev/null; then
        print_fail "Se necesitan permisos de superusuario."
        exit 1
    fi
    # Mantener sudo activo en background
    ( while true; do sudo -v; sleep 50; done ) &
    SUDO_KEEPALIVE_PID=$!
    trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT
}

# ── Verificar conexión a internet ─────────────────────────────────
check_internet() {
    if ! ping -c 1 -W 3 8.8.8.8 &>/dev/null; then
        print_warn "Sin conexión a internet. Algunos paquetes pueden fallar."
        confirm "¿Continuar de todas formas?" || exit 0
    fi
}
