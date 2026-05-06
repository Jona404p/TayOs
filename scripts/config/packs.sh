#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  TayOs Software Center — Definición de Packs
#  Edita aquí para agregar/quitar paquetes sin tocar los scripts
# ══════════════════════════════════════════════════════════════════

# ── 💼 Trabajo ────────────────────────────────────────────────────
PACK_WORK_NAME="Trabajo & Oficina"
PACK_WORK_ICON="💼"
PACK_WORK=(
    libreoffice
    thunderbird
    remmina
    gimp
    inkscape
    evince
    obsidian
    nextcloud-desktop
)

# ── 🛡️ Ciberseguridad ─────────────────────────────────────────────
PACK_CYBER_NAME="Ciberseguridad"
PACK_CYBER_ICON="🛡️"
PACK_CYBER=(
    nmap
    wireshark
    tcpdump
    net-tools
    john
    hashcat
    hydra
    aircrack-ng
    nikto
    sqlmap
    netcat-openbsd
    traceroute
    whois
    dnsutils
    tor
)

# ── 🎮 Gaming ─────────────────────────────────────────────────────
PACK_GAMING_NAME="Gaming"
PACK_GAMING_ICON="🎮"
PACK_GAMING=(
    steam
    lutris
    wine
    wine64
    gamemode
    mesa-utils
    vulkan-tools
    mangohud
)

# ── 👨‍💻 Programación ──────────────────────────────────────────────
PACK_DEV_NAME="Programación & Dev"
PACK_DEV_ICON="👨‍💻"
PACK_DEV=(
    git
    build-essential
    python3
    python3-pip
    python3-venv
    nodejs
    npm
    curl
    jq
    vim
    neovim
    docker.io
    docker-compose
)

# ── 🧠 IA Stack ───────────────────────────────────────────────────
PACK_AI_NAME="IA & Machine Learning"
PACK_AI_ICON="🧠"
PACK_AI_APT=(
    python3-pip
    python3-venv
    ffmpeg
    libportaudio2
)
# Modelos Ollama a descargar
PACK_AI_MODELS=(
    "llama3.2:3b"
    "phi3:mini"
)

# ── 🎵 Multimedia ─────────────────────────────────────────────────
PACK_MEDIA_NAME="Multimedia"
PACK_MEDIA_ICON="🎵"
PACK_MEDIA=(
    vlc
    mpv
    audacity
    kdenlive
    obs-studio
    ffmpeg
    handbrake
    spotify-client
)

# ── 🌐 Internet & Comunicación ────────────────────────────────────
PACK_NET_NAME="Internet & Comunicación"
PACK_NET_ICON="🌐"
PACK_NET=(
    firefox-esr
    chromium
    telegram-desktop
    signal-desktop
    filezilla
    transmission-gtk
    qbittorrent
)

# ── ⚙️ Sistema & Utilidades ───────────────────────────────────────
PACK_SYS_NAME="Sistema & Utilidades"
PACK_SYS_ICON="⚙️"
PACK_SYS=(
    htop
    btop
    neofetch
    fastfetch
    gparted
    timeshift
    bleachbit
    stacer
    cpu-x
    hardinfo
    smartmontools
    tree
    bat
    fd-find
    ripgrep
)
