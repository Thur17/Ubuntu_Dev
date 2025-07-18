#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

echo "🟢 Iniciando pós-instalação Ubuntu 24.04.2 LTS..."

# Atualizar sistema
echo "🔄 Atualizando o sistema..."
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y

# Instalar Neofetch
echo "🖥️ Instalando Neofetch..."
sudo apt install -y neofetch

# Instalar utilitários básicos
echo "🛠️ Instalando utilitários básicos..."
sudo apt-get install -y gnome-tweaks gnome-extensions-app git curl rsync vim vlc htop

# Instalar gnome-shell-extension-installer e extensões GNOME
echo "🔧 Instalando gnome-shell-extension-installer..."
sudo apt install -y git curl

curl -Lo gnome-shell-extension-installer https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/local/bin/

echo "🧩 Instalando extensões GNOME..."
gnome-shell-extension-installer 615 AppIconsTaskbar --yes
gnome-shell-extension-installer 6 AppsMenu --yes
gnome-shell-extension-installer 517 Caffeine --yes
gnome-shell-extension-installer 2087 DesktopIconsNG --yes
gnome-shell-extension-installer 615 MediaControls --yes
gnome-shell-extension-installer 516 QuickSettingsAudioPanel --yes
gnome-shell-extension-installer 435 ResourceMonitor --yes
gnome-shell-extension-installer 5721 TailscaleStatus --yes
gnome-shell-extension-installer 615 UbuntuAppIndicators --yes
gnome-shell-extension-installer 307 UbuntuDock --yes
gnome-shell-extension-installer 19 UserThemes --yes

echo "🚀 Ativando extensões GNOME..."
gnome-extensions enable app-icons-taskbar@p11y.com || true
gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com || true
gnome-extensions enable caffeine@patapon.info || true
gnome-extensions enable ding@rastersoft.com || true
gnome-extensions enable mediacontrols@clameur.me || true
gnome-extensions enable quicksettings-audio-panel@pappas.dev || true
gnome-extensions enable resource-monitor@paradoxxx.zero.gmail.com || true
gnome-extensions enable tailscale-status@k3a.me || true
gnome-extensions enable ubuntu-appindicators@ubuntu.com || true
gnome-extensions enable ubuntu-dock@ubuntu.com || true
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com || true

# Instalar Snap e Flatpak
echo "📦 Instalando Snap e Flatpak..."
sudo apt install -y snapd flatpak gnome-software-plugin-flatpak

# Instalar Google Chrome
echo "🌐 Instalando Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

# Instalar Visual Studio Code
echo "🧰 Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm packages.microsoft.gpg
sudo apt update
sudo apt install -y code

# Instalar extensões VS Code
echo "⚙️ Instalando extensões VS Code..."
declare -a extensions=(
  GitHub.copilot-chat
  vscode-icons-team.vscode-icons
  Vue.volar
  ms-azuretools.vscode-containers
  ms-vscode-remote.remote-containers
  ms-azuretools.vscode-docker
  docker.docker
  dracula-theme.theme-dracula
  waderyan.gitblame
  GitHub.copilot
  ecmel.vscode-html-css
  oderwat.indent-rainbow
  VisualStudioExptTeam.vscodeintellicode
  Zignd.html-css-class-completion
  ms-vscode.live-server
  ritwickdey.LiveServer
  DavidAnson.vscode-markdownlint
  bmewburn.vscode-intelephense-client
  MS-CEINTL.vscode-language-pack-pt-BR
  esbenp.prettier-vscode
  hollowtree.vue-snippets
)

for ext in "${extensions[@]}"; do
  code --install-extension "$ext" || echo "⚠️ Falha ao instalar extensão $ext"
done

# Instalar Postman via Snap
echo "📮 Instalando Postman via Snap..."
sudo snap install postman

# Instalar MySQL Workbench e servidor
echo "🐬 Instalando MySQL Workbench e servidor MySQL..."
sudo apt install -y mysql-workbench mysql-server

# Instalar Docker Engine
echo "🐳 Instalando Docker Engine..."

sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

docker --version

# Permitir usar docker sem sudo para usuário atual
sudo usermod -aG docker $(whoami) && newgrp docker

# Instalar ONLYOFFICE
echo "📄 Instalando ONLYOFFICE Desktop Editors..."
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
wget -qO - https://download.onlyoffice.com/repo/onlyoffice.key | sudo apt-key add -
sudo apt update
sudo apt install -y onlyoffice-desktopeditors

# Instalar Remmina com plugins
echo "🖥️ Instalando Remmina com suporte RDP, VNC, SSH..."
sudo apt update
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret

# Instalar AnyDesk
echo "🧑‍💻 Instalando AnyDesk..."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /usr/share/keyrings/anydesk.gpg
echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update
sudo apt install -y anydesk

# Instalar Spotify
echo "🎵 Instalando Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# Instalar Bitwarden via Snap
echo "🔐 Instalando Bitwarden via Snap..."
sudo snap install bitwarden

# Instalar OBS Studio
echo "🎥 Instalando OBS Studio..."
sudo apt update
sudo apt install -y obs-studio

# Atualização final e limpeza
echo "✅ Atualizando sistema e limpando..."
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
sudo apt clean

echo "🎉 Pós-instalação finalizada com sucesso!"
echo "Reinicie o sistema para aplicar todas as alterações, especialmente para o Docker."
echo "🔄 Reiniciando o sistema..."
sudo init 6
# Fim do script
