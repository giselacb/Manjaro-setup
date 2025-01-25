#!/bin/bash

# Colores para los mensajes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Iniciando configuración de entorno SRE en Manjaro...${NC}"

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Actualizar sistema
echo -e "${BLUE}🔄 Actualizando el sistema...${NC}"
sudo pacman -Syu --noconfirm

# Instalar yay si no está instalado
if ! command_exists yay; then
    echo -e "${GREEN}🔧 Instalando yay...${NC}"
    sudo pacman -S --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Instalar herramientas básicas
echo -e "${BLUE}🛠️ Instalando herramientas básicas...${NC}"
sudo pacman -S --noconfirm \
    konsole \
    zsh \
    exa \
    bat \
    ripgrep \
    fd \
    fzf \
    btop \
    neofetch \
    git \
    docker \
    docker-compose \
    kubectl \
    k9s \
    helm \
    github-cli

# Instalar aplicaciones
echo -e "${BLUE}🌐 Instalando aplicaciones...${NC}"
yay -S --noconfirm \
    google-chrome \
    visual-studio-code-bin \
    cursor-bin \
    slack-desktop

# Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}📚 Instalando Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Instalar Spaceship Prompt
echo -e "${GREEN}🎨 Instalando Spaceship Prompt...${NC}"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Instalar plugins de zsh
echo -e "${BLUE}🔌 Instalando plugins de Zsh...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configurar Zsh
echo -e "${BLUE}⚙️ Configurando Zsh...${NC}"
cat > ~/.zshrc << 'EOF'
# Config básica
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"

# Configuración de Spaceship
SPACESHIP_PROMPT_ORDER=(
  user          # Usuario y host
  dir           # Directorio actual
  git           # Git status
  kubectl       # Contexto Kubernetes
  exit_code     # Estado del último comando
  char          # Carácter del prompt
)

# Configuración para una línea
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Mostrar información relevante
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always
SPACESHIP_DIR_TRUNC_LENGTH=1
SPACESHIP_EXIT_CODE_SHOW=true

# Configuración específica de kubectl
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_KUBECTL_CONTEXT_SHOW=true

# Símbolos con iconos
SPACESHIP_GIT_SYMBOL="🌱 "
SPACESHIP_KUBECTL_SYMBOL="☸️ "
SPACESHIP_ERROR_SYMBOL="✘"

# Colores pastel
SPACESHIP_DIR_COLOR="cyan"
SPACESHIP_GIT_BRANCH_COLOR="magenta"
SPACESHIP_KUBECTL_COLOR="blue"
SPACESHIP_USER_COLOR="green"
SPACESHIP_HOST_COLOR="yellow"

# Plugins
plugins=(
    git
    docker
    docker-compose
    kubectl
    helm
    terraform
    github
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Configuración de histórico
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt AUTO_CD

# Alias modernos
alias ls='exa --icons --git'
alias ll='exa -l --icons --git'
alias la='exa -la --icons --git'
alias cat='bat'
alias top='btop'

# Alias para Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'

# Alias para Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias k9='k9s'

# Alias para Git
alias g='git'
alias gs='git status'
alias gp='git pull'
alias gph='git push'
alias gc='git commit'
alias gco='git checkout'

# Alias para Helm
alias h='helm'
alias hl='helm list'
alias hi='helm install'
alias hu='helm uninstall'
alias hd='helm dependency update'
alias hh='helm history'
alias hr='helm rollback'
alias hv='helm version'
alias hdep='helm dependency'
alias hg='helm get'
alias hgv='helm get values'
alias hgm='helm get manifest'
alias hga='helm get all'
alias ht='helm template'
alias hlv='helm list --all-versions'

# Variables de entorno
export EDITOR='nano'
export VISUAL='nano'
export KUBE_EDITOR='nano'

# Autocompletado
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Función de ayuda para alias
function halias() {
    echo "\n🔍 Aliases Disponibles:\n"
    
    echo "=== Docker ==="
    echo "d          → docker"
    echo "dc         → docker-compose"
    echo "dps        → docker ps"
    echo "di         → docker images"
    echo "dex        → docker exec -it"
    echo "dcup       → docker-compose up -d"
    echo "dcdown     → docker-compose down"
    
    echo "\n=== Kubernetes ==="
    echo "k          → kubectl"
    echo "kgp        → kubectl get pods"
    echo "kgd        → kubectl get deployments"
    echo "kgs        → kubectl get services"
    echo "k9         → k9s"
    
    echo "\n=== Git ==="
    echo "g          → git"
    echo "gs         → git status"
    echo "gp         → git pull"
    echo "gph        → git push"
    echo "gc         → git commit"
    echo "gco        → git checkout"
    
    echo "\n=== Helm ==="
    echo "h          → helm"
    echo "hl         → helm list"
    echo "hi         → helm install"
    echo "hu         → helm uninstall"
    echo "hd         → helm dependency update"
    echo "hh         → helm history"
    echo "hr         → helm rollback"
    echo "hv         → helm version"
    echo "hdep       → helm dependency"
    echo "hg         → helm get"
    echo "hgv        → helm get values"
    echo "hgm        → helm get manifest"
    echo "hga        → helm get all"
    echo "ht         → helm template"
    echo "hlv        → helm list --all-versions"
    
    echo "\n=== Sistema ==="
    echo "ls         → exa --icons --git"
    echo "ll         → exa -l --icons --git"
    echo "la         → exa -la --icons --git"
    echo "cat        → bat"
    echo "top        → btop"
    echo "help       → mostrar esta ayuda"
}

# Alias para la ayuda
alias help='halias'
EOF

# Configurar nano
echo -e "${BLUE}📝 Configurando nano...${NC}"
cat > ~/.nanorc << 'EOF'
# Configuración básica de nano
set smooth            # Scroll suave
set constantshow     # Mostrar información constante
set linenumbers      # Mostrar números de línea
set softwrap        # Ajuste de línea suave
set tabsize 2       # Tamaño de tabulación = 2
set tabstospaces    # Tabs como espacios
set mouse          # Soporte para ratón

# Configuración de colores minimalista
# Usar los colores del sistema
set titlecolor bold,white
set statuscolor bold,white
set selectedcolor bold
set numbercolor cyan
set keycolor cyan
set functioncolor normal

# Incluir sintaxis básicas
include "/usr/share/nano/sh.nanorc"
include "/usr/share/nano/python.nanorc"
include "/usr/share/nano/yaml.nanorc"
include "/usr/share/nano/json.nanorc"
include "/usr/share/nano/markdown.nanorc"
include "/usr/share/nano/git.nanorc"
EOF

# Configurar Docker
echo -e "${BLUE}🐳 Configurando Docker...${NC}"
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Instalar fuentes
echo -e "${BLUE}📝 Instalando fuentes...${NC}"
yay -S --noconfirm ttf-meslo-nerd-font-powerlevel10k

# Mensaje final
echo -e "${GREEN}✅ Configuración completada!${NC}"
echo -e "${BLUE}Por favor, realiza las siguientes acciones:${NC}"
echo "1. Reinicia tu terminal"
echo "2. El tema Spaceship está configurado con una personalización optimizada para SRE"
echo "3. Cierra sesión y vuelve a entrar para que los cambios en el grupo docker surtan efecto"
echo "4. Configura Git y GitHub:"
echo "   git config --global user.name \"Tu Nombre\""
echo "   git config --global user.email \"tu@email.com\""
echo "   Para autenticarte en GitHub, ejecuta:"
echo "   gh auth login"
echo "   Sigue las instrucciones para autenticarte con tu navegador"
EOF
