<div align="center">

# 🏠 Dotfiles

**✨ One command to rule them all ✨**

![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Tmux](https://img.shields.io/badge/Tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Ghostty](https://img.shields.io/badge/Ghostty-000000?style=for-the-badge&logo=ghostty&logoColor=white)

Dotfiles for bootstrapping and backing up my Mac development environment.
A single `./install` script symlinks configs into place and installs all dependencies via Homebrew.

---

</div>

## 📦 What's Included

| | Module | Description |
|---|--------|-------------|
| 🐚 | **zsh** | Oh My Zsh + Powerlevel10k, autosuggestions, syntax highlighting, lazy NVM, custom aliases |
| 📝 | **nvim** | Neovim with Lazy.nvim — LSP, Treesitter, Telescope, Neo-tree, DAP & 40+ plugins |
| 🖥️ | **tmux** | Vi-mode, true color, mouse support, session persistence (resurrect/continuum, auto-boot in Ghostty), modular config |
| 🍺 | **homebrew** | Brewfile with CLI tools, languages, services, Colima (Docker runtime), and fonts |
| 🦥 | **lazygit** | Tokyo Night-themed lazygit config |
| ⚡ | **scripts** | `t` (tmux session switcher), `update` (update all tools), `nvim-health` (setup checker) — linked into `~/.local/bin` |
| 📗 | **nvm** | Default global npm packages (LSP servers, formatters, linters) |
| 👻 | **ghostty** | Ghostty terminal config |
| 🖼️ | **iterm** | Exported iTerm2 profile backup |
| 🔧 | **git** | Git config with aliases, global gitignore |
| 🍎 | **macos** | macOS system preferences script (keyboard, Finder, Dock, screenshots) |
| 📐 | **editorconfig** | 2-space indent (4 for PHP/Python), LF endings, UTF-8 |
| 🐳 | **docker** | Docker via [Colima](https://github.com/abiosoft/colima) instead of Docker Desktop (`DOCKER_HOST` set in `.zshrc`) |
| 🤖 | **claude** | Claude Code settings → `~/.claude/settings.json` *(gitignored)* |

---

## 🚀 Installation

```sh
chmod +x install
./install
```

<details>
<summary>📋 What the install script does</summary>

| Step | Action |
|------|--------|
| 1️⃣ | Install Xcode Command Line Tools (if missing) |
| 2️⃣ | Install Oh My Zsh (if missing) |
| 3️⃣ | Install Homebrew (if missing) |
| 4️⃣ | Symlink dotfiles (`~/.zshrc`, `~/.zprofile`, `~/.p10k.zsh`, `~/.tmux.conf`, `~/.config/nvim`, scripts → `~/.local/bin`, etc.) |
| 5️⃣ | Run `brew bundle` to install everything in the Brewfile, then link the Ghostty config |
| 6️⃣ | Set up NVM with default packages |
| 7️⃣ | Symlink lazygit, Claude settings, editorconfig, & git config |
| 8️⃣ | Clone TPM (Tmux Plugin Manager) |
| 9️⃣ | Apply macOS system preferences |
| 🔟 | Create `~/Code` workspace directory |

</details>

### 🧰 Makefile

You can also install modules selectively:

```sh
make brew        # Just install Homebrew packages
make nvim        # Just symlink Neovim config
make tmux        # Just set up tmux
make zsh         # Just link zsh config
make nvm         # Just set up NVM defaults
make ghostty     # Just link Ghostty config
make update      # Quick update (brew, nvim plugins, tpm)
make clean       # Remove all symlinks (uninstall)
```

---

## 🗂️ Structure

```
.
├── 🍺 homebrew/Brewfile           # Homebrew dependencies
├── ⚙️  install                     # Bootstrap script
├── 🗑️  uninstall                   # Remove all symlinks
├── 📋 Makefile                    # Selective install targets
├── 🌙 .emmyrc.json                # Lua language server settings
├── 👻 ghostty/
│   └── config.ghostty             # Ghostty terminal config
├── 🖼️  iterm/backup.itermexport    # iTerm2 profile
├── 🦥 lazygit/config.yml          # Lazygit theme
├── 🔧 git/
│   ├── gitconfig                  # Git aliases & settings
│   └── .gitignore_global          # Global ignores
├── 🍎 macos/
│   └── defaults.sh               # macOS system preferences
├── 📝 nvim/                       # Neovim config (Lazy.nvim)
│   ├── init.lua
│   ├── lua/user/                  # Options, keymaps, plugin specs
│   └── snippets/                  # Snippets (TS, TSX)
├── 📗 nvm/default-packages        # Global npm packages
├── ⚡ scripts/
│   ├── t                          # Tmux session switcher
│   ├── update                     # Update brew, nvim, Node LTS, tpm, omz
│   └── nvim-health                # Neovim setup health check
├── 🖥️  tmux/
│   ├── tmux.conf                  # Core settings & TPM plugin list
│   ├── theme.conf                 # Status line & colors
│   ├── keybindings.conf           # Key bindings
│   └── plugins.conf               # resurrect/continuum settings
├── 🐚 zsh/
│   ├── .zprofile                  # Login shell (Homebrew)
│   ├── .zshrc                     # Shell config
│   ├── .p10k.zsh                 # Powerlevel10k theme
│   └── custom/
│       ├── aliases.zsh            # Custom aliases
│       ├── tools.zsh              # pyenv init
│       ├── local.zsh.example      # Machine-specific template
│       ├── plugins/               # Oh My Zsh plugins
│       └── themes/                # Oh My Zsh themes
├── 📐 .editorconfig               # Editor formatting rules
└── 🤫 .hushlogin                  # Suppress login banner
```

---

## 🛠️ Key Tools

### 💬 Languages & Runtimes

![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat-square&logo=nodedotjs&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Go](https://img.shields.io/badge/Go-00ADD8?style=flat-square&logo=go&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)
![Deno](https://img.shields.io/badge/Deno-000000?style=flat-square&logo=deno&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)

### 🔧 CLI Tools

`ripgrep` · `fzf` · `lazygit` · `gh` · `awscli` · `kubectl` · `colima` · `docker` · `buf` · `pipx` · `cmake` · `graphviz` · `wget` · `ngrok`

### 🔤 Fonts

`Fira Code` · `Fira Code Nerd Font`

### 🗄️ Services

![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat-square&logo=redis&logoColor=white)
![RabbitMQ](https://img.shields.io/badge/RabbitMQ-FF6600?style=flat-square&logo=rabbitmq&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL_14-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker_(Colima)-2496ED?style=flat-square&logo=docker&logoColor=white)

Start the Docker runtime with `colima start`.

### ✏️ Neovim Highlights

> 🎨 **Tokyo Night** colorscheme · 🔭 **Telescope** fuzzy finder · 🌳 **Neo-tree** & **Oil** file management · 🧠 **LSP** (TypeScript, Lua, Bash, Vue, PHP, JSON, CSS/HTML) · 💡 **nvim-cmp** completions · 🧹 **conform.nvim** formatting (ESLint/Prettier, incl. Vue) · 🔍 **nvim-lint** · 🐛 **DAP** debugging · 🧪 **Neotest** · 📊 **Gitsigns** & **Fugitive** · 📑 **Bufferline** · 🚀 **Lualine** · ⌨️ **which-key** · 📸 **CodeSnap** screenshots

---

## ⌨️ Custom Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `lg` | `lazygit` | 🦥 Open lazygit |
| `zshreload` | `source ~/.zshrc` | 🔁 Reload shell config |
| `wip` | `git add . && git commit -m 'chore: wip'` | 💾 Quick work-in-progress commit |
| `code` | `cd ~/Code` | 📂 Jump to projects |
| `..` / `...` / `....` | `cd` up 1/2/3 levels | 🔼 Quick navigation |
| `ll` | `ls -lAFh` | 📋 Detailed file listing |
| `la` | `ls -A` | 👀 List including dotfiles |
| `mkcd <dir>` | `mkdir -p && cd` | 📁 Create & enter directory |

---

## 🔄 Maintenance

```sh
update          # Run from anywhere — updates brew, nvim plugins, Node (latest LTS), tpm, omz
nvim-health     # Check that LSP servers, formatters, and tools are installed
```

---

## 🖥️ Machine-Specific Overrides

Create `zsh/custom/local.zsh` (gitignored) for settings that shouldn't be committed:

```sh
cp zsh/custom/local.zsh.example zsh/custom/local.zsh
```

---

## 🙏 Credits

| | |
|---|---|
| 📝 | Neovim config heavily influenced by [**Jess Archer**](https://github.com/jessarcher) — see their course on [Laracasts](https://laracasts.com/series/neovim-as-a-php-ide) |
| ⚡ | Tmux session script (`t`) inspired by [**ThePrimeagen**](https://github.com/ThePrimeagen) |
| 💡 | More dotfile inspiration at [**dotfiles.github.io**](https://dotfiles.github.io/inspiration/) |

---

<div align="center">

**⚡ Happy hacking! ⚡**

</div>
