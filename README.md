<div align="center">

<img src="https://github.com/Jona404p/TayOs/blob/main/wallpapersTY/Wall1.png" alt="TayOs Software Center" width="100%"/>

# 🌸 TayOs Software Center

**Gestor de paquetes por categorías para TayOs — instala lo que necesitas, cuando lo necesitas.**

[![TayOs](https://img.shields.io/badge/TayOs-Software%20Center-7c3aed?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/JonathanPaniagua)
[![Shell](https://img.shields.io/badge/Shell-Bash-a78bfa?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/Licencia-MIT-e9d5ff?style=for-the-badge)](LICENSE)
[![Packs](https://img.shields.io/badge/Packs-8%20categorías-1a1a2e?style=for-the-badge)](scripts/config/packs.sh)

</div>

---

## ¿Qué es esto?

TayOs Software Center es un sistema de scripts Bash que organiza aplicaciones por categorías llamadas **packs**. En lugar de buscar e instalar programas uno a uno, seleccionas el pack que necesitas y el sistema lo instala todo automáticamente, mostrando progreso en tiempo real, detectando paquetes ya instalados y registrando todo en un log.

Funciona en **TayOs** y cualquier distribución basada en **Debian/Ubuntu**.

---

## ✨ Características

- **8 packs temáticos** — Trabajo, Ciberseguridad, Gaming, Dev, IA, Multimedia, Internet y Sistema
- **Menú interactivo** con colores y barra de progreso en tiempo real
- **Detección inteligente** — salta los paquetes ya instalados
- **Modo CLI** — instala un pack directamente sin abrir el menú
- **Dry-run** — simula la instalación sin instalar nada, ideal para pruebas
- **Log automático** guardado en `/tmp/tayos-center.log`
- **Resumen al finalizar** con lista de paquetes que fallaron
- **Fácil de extender** — agrega paquetes editando un solo archivo

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/Jona404p/TayOs.git
cd TayOs
bash setup.sh
```

El script `setup.sh` configura permisos y opcionalmente crea un alias `TayOs` en tu terminal.

---

## 📦 Packs disponibles

| Pack | Aplicaciones incluidas |
|------|------------------------|
| 💼 **Trabajo & Oficina** | LibreOffice, Thunderbird, GIMP, Inkscape, Obsidian, Remmina, Nextcloud |
| 🛡️ **Ciberseguridad** | Nmap, Wireshark, Hydra, Hashcat, SQLMap, Nikto, Aircrack-ng, Tcpdump, tor |
| 🎮 **Gaming** | Steam, Lutris, Wine, MangoHud, GameMode, Vulkan Tools, Mesa |
| 👨‍💻 **Programación** | Git, Python 3, Node.js, Docker, VS Code, Neovim, build-essential |
| 🧠 **IA Stack** | Ollama + modelos llama3.2:3b y phi3:mini listos para usar localmente |
| 🎵 **Multimedia** | VLC, OBS Studio, Audacity, Kdenlive, Spotify, Handbrake, FFmpeg |
| 🌐 **Internet** | Firefox, Chromium, Telegram, Signal, qBittorrent, FileZilla |
| ⚙️ **Sistema** | btop, GParted, Timeshift, BleachBit, ripgrep, bat, fd-find, fastfetch |

---

## 🖥️ Uso

### Menú interactivo

```bash
bash scripts/menu.sh
```

Muestra un menú con todos los packs disponibles. Puedes instalar uno o todos a la vez.

### Instalar un pack directamente

```bash
bash scripts/menu.sh --pack work        # 💼 Trabajo & Oficina
bash scripts/menu.sh --pack cyber       # 🛡️ Ciberseguridad
bash scripts/menu.sh --pack gaming      # 🎮 Gaming
bash scripts/menu.sh --pack dev         # 👨‍💻 Programación
bash scripts/menu.sh --pack ai          # 🧠 IA Stack
bash scripts/menu.sh --pack media       # 🎵 Multimedia
bash scripts/menu.sh --pack internet    # 🌐 Internet
bash scripts/menu.sh --pack system      # ⚙️ Sistema
bash scripts/menu.sh --pack all         # 🚀 Todos los packs
```

### Opciones adicionales

```bash
--dry-run    # Simula la instalación sin instalar nada
--quiet      # Modo silencioso (solo errores)
--help       # Muestra la ayuda completa
```

---

## 📁 Estructura del proyecto

```
tayos-center/
├── setup.sh                         ← Configuración inicial (permisos + alias)
├── scripts/
│   ├── menu.sh                      ← Menú principal e intérprete de CLI
│   ├── core/
│   │   └── utils.sh                 ← Colores, logging, barra de progreso, instalador
│   ├── config/
│   │   └── packs.sh                 ← Definición de todos los packs y sus paquetes
│   └── install/
│       ├── work.sh                  ← 💼 Trabajo & Oficina
│       ├── cybersecurity.sh         ← 🛡️ Ciberseguridad
│       ├── gaming.sh                ← 🎮 Gaming
│       ├── programming.sh           ← 👨‍💻 Programación
│       ├── ai-stack.sh              ← 🧠 IA Stack
│       ├── multimedia.sh            ← 🎵 Multimedia
│       ├── internet.sh              ← 🌐 Internet
│       └── system.sh                ← ⚙️ Sistema
└── README.md
```

---

## ✏️ Personalizar paquetes

Todos los packs se definen en **`scripts/config/packs.sh`**. Puedes agregar o quitar paquetes de cualquier pack sin tocar los scripts de instalación.

```bash
# Ejemplo: agregar 'vlc' al pack de trabajo
PACK_WORK=(
    libreoffice
    thunderbird
    vlc            # ← agrégalo aquí y listo
)
```

Para crear un pack nuevo, agrega el array en `packs.sh`, crea su script en `install/` siguiendo la misma estructura de los existentes, y agrégalo al menú en `menu.sh`.

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Si quieres agregar un pack, corregir un paquete o mejorar algún script, abre un **issue** o un **pull request**.

1. Haz fork del repositorio
2. Crea una rama: `git checkout -b feat/mi-mejora`
3. Haz tus cambios y commitea: `git commit -m "feat: descripción"`
4. Push y abre un pull request

---

<div align="center">

Hecho con 💜 por **Jonathan Paniagua** · TayOs ⚜️

</div>
