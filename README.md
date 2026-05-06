# 🌸 TayOs Software Center______Jonatan Paniagua Vazquez

Centro de instalación de aplicaciones para **TayOs** — instala packs completos de software con un solo comando.

## 📁 Estructura

```
scripts/
├── menu.sh                  ← Punto de entrada principal
├── core/
│   └── utils.sh             ← Funciones compartidas (logging, colores, instalador)
├── config/
│   └── packs.sh             ← Definición de todos los packs y paquetes
└── install/
    ├── work.sh              ← 💼 Trabajo & Oficina
    ├── cybersecurity.sh     ← 🛡️ Ciberseguridad
    ├── gaming.sh            ← 🎮 Gaming
    ├── programming.sh       ← 👨‍💻 Programación & Dev
    ├── ai-stack.sh          ← 🧠 IA & Machine Learning
    ├── multimedia.sh        ← 🎵 Multimedia
    ├── internet.sh          ← 🌐 Internet & Comunicación
    └── system.sh            ← ⚙️ Sistema & Utilidades
```

## 🚀 Uso rápido

```bash
# Clonar el repo
git clone https://github.com/TU_USUARIO/tayos-center.git
cd tayos-center

# Dar permisos
chmod +x scripts/menu.sh scripts/install/*.sh scripts/core/*.sh

# Lanzar el menú interactivo
bash scripts/menu.sh
```

### Instalar un pack directamente

```bash
bash scripts/menu.sh --pack work       # Trabajo & Oficina
bash scripts/menu.sh --pack cyber      # Ciberseguridad
bash scripts/menu.sh --pack gaming     # Gaming
bash scripts/menu.sh --pack dev        # Programación
bash scripts/menu.sh --pack ai         # IA Stack
bash scripts/menu.sh --pack media      # Multimedia
bash scripts/menu.sh --pack internet   # Internet
bash scripts/menu.sh --pack system     # Sistema
bash scripts/menu.sh --pack all        # Todos los packs
```

### Opciones adicionales

```bash
--dry-run    # Simula sin instalar nada (para pruebas)
--quiet      # Modo silencioso
--help       # Muestra ayuda
```

## 📦 Packs disponibles

| Pack | Incluye |
|------|---------|
| 💼 Trabajo | LibreOffice, Thunderbird, GIMP, Inkscape, Remmina... |
| 🛡️ Ciberseguridad | Nmap, Wireshark, Hydra, Hashcat, SQLMap... |
| 🎮 Gaming | Steam, Lutris, Wine, MangoHud, GameMode... |
| 👨‍💻 Dev | Git, Python3, Node.js, Docker, VS Code... |
| 🧠 IA | Ollama + modelos llama3.2:3b y phi3:mini |
| 🎵 Multimedia | VLC, OBS Studio, Audacity, Kdenlive, Spotify... |
| 🌐 Internet | Firefox, Chromium, Telegram, Signal, qBittorrent... |
| ⚙️ Sistema | btop, GParted, Timeshift, BleachBit, ripgrep... |

## ✏️ Personalizar paquetes

Edita `scripts/config/packs.sh` para agregar o quitar paquetes de cualquier pack **sin tocar los scripts de instalación**.

```bash
# Ejemplo: agregar 'vlc' al pack de trabajo
PACK_WORK=(
    libreoffice
    thunderbird
    vlc          # ← simplemente agrégalo aquí
)
```

## 📋 Logs

Los logs se guardan automáticamente en `/tmp/tayos-center.log`.

---

Hecho con ❤️ para TayOs
