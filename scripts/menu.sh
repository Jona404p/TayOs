#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Menú Principal
#  Uso: ./menu.sh [--dry-run] [--quiet] [--pack <nombre>]
# ══════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/core/utils.sh"
source "$SCRIPT_DIR/config/packs.sh"

# ── Parsear argumentos CLI ────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  export DRY_RUN=true;  shift ;;
        --quiet)    export QUIET_MODE=true; shift ;;
        --pack)     DIRECT_PACK="$2"; shift 2 ;;
        --help|-h)
            echo "Uso: $0 [--dry-run] [--quiet] [--pack <nombre>]"
            echo ""
            echo "  --dry-run        Simula la instalación sin instalar nada"
            echo "  --quiet          Modo silencioso (solo errores)"
            echo "  --pack <nombre>  Instala directamente un pack:"
            echo "                   work | cyber | gaming | dev | ai"
            echo "                   media | internet | system | all"
            exit 0
            ;;
        *) echo "Argumento desconocido: $1"; exit 1 ;;
    esac
done

# ── Mapa de packs disponibles ─────────────────────────────────────
declare -A PACK_SCRIPTS=(
    [work]="$SCRIPT_DIR/install/work.sh"
    [cyber]="$SCRIPT_DIR/install/cybersecurity.sh"
    [gaming]="$SCRIPT_DIR/install/gaming.sh"
    [dev]="$SCRIPT_DIR/install/programming.sh"
    [ai]="$SCRIPT_DIR/install/ai-stack.sh"
    [media]="$SCRIPT_DIR/install/multimedia.sh"
    [internet]="$SCRIPT_DIR/install/internet.sh"
    [system]="$SCRIPT_DIR/install/system.sh"
)

# ── Instalar pack directo por CLI ─────────────────────────────────
if [[ -n "$DIRECT_PACK" ]]; then
    if [[ "$DIRECT_PACK" == "all" ]]; then
        for key in "${!PACK_SCRIPTS[@]}"; do
            bash "${PACK_SCRIPTS[$key]}"
        done
        exit 0
    elif [[ -n "${PACK_SCRIPTS[$DIRECT_PACK]}" ]]; then
        bash "${PACK_SCRIPTS[$DIRECT_PACK]}"
        exit 0
    else
        echo "Pack desconocido: $DIRECT_PACK"
        echo "Disponibles: ${!PACK_SCRIPTS[*]}"
        exit 1
    fi
fi

# ── Menú interactivo ──────────────────────────────────────────────
show_menu() {
    print_banner

    [[ "$DRY_RUN" == "true" ]] && \
        echo -e "  ${YELLOW}${BOLD}  ⚠  MODO DRY-RUN — no se instalará nada  ⚠${RESET}\n"

    echo -e "  ${BOLD}Selecciona un pack para instalar:${RESET}"
    echo ""
    echo -e "   ${CYAN}1)${RESET} ${PACK_WORK_ICON}  ${PACK_WORK_NAME}"
    echo -e "   ${CYAN}2)${RESET} ${PACK_CYBER_ICON}  ${PACK_CYBER_NAME}"
    echo -e "   ${CYAN}3)${RESET} ${PACK_GAMING_ICON}  ${PACK_GAMING_NAME}"
    echo -e "   ${CYAN}4)${RESET} ${PACK_DEV_ICON}  ${PACK_DEV_NAME}"
    echo -e "   ${CYAN}5)${RESET} ${PACK_AI_ICON}  ${PACK_AI_NAME}"
    echo -e "   ${CYAN}6)${RESET} ${PACK_MEDIA_ICON}  ${PACK_MEDIA_NAME}"
    echo -e "   ${CYAN}7)${RESET} ${PACK_NET_ICON}  ${PACK_NET_NAME}"
    echo -e "   ${CYAN}8)${RESET} ${PACK_SYS_ICON}  ${PACK_SYS_NAME}"
    echo ""
    echo -e "   ${MAGENTA}9)${RESET} 🚀  Instalar TODOS los packs"
    echo -e "   ${DIM}0)  Salir${RESET}"
    echo ""
    echo -ne "  ${BOLD}Opción: ${RESET}"
}

# ── Bucle principal ───────────────────────────────────────────────
while true; do
    show_menu
    read -r opt

    case "$opt" in
        1) bash "$SCRIPT_DIR/install/work.sh"         ;;
        2) bash "$SCRIPT_DIR/install/cybersecurity.sh" ;;
        3) bash "$SCRIPT_DIR/install/gaming.sh"        ;;
        4) bash "$SCRIPT_DIR/install/programming.sh"   ;;
        5) bash "$SCRIPT_DIR/install/ai-stack.sh"      ;;
        6) bash "$SCRIPT_DIR/install/multimedia.sh"    ;;
        7) bash "$SCRIPT_DIR/install/internet.sh"      ;;
        8) bash "$SCRIPT_DIR/install/system.sh"        ;;
        9)
            echo ""
            print_warn "Esto instalará TODOS los packs. Puede tardar bastante."
            if confirm "¿Continuar?"; then
                for key in work cyber gaming dev ai media internet system; do
                    bash "${PACK_SCRIPTS[$key]}"
                done
            fi
            ;;
        0|q|Q)
            echo ""
            echo -e "  ${DIM}Hasta luego. 👋${RESET}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}Opción inválida.${RESET}"
            ;;
    esac

    echo ""
    echo -ne "  ${DIM}Presiona ENTER para volver al menú...${RESET}"
    read -r
done
