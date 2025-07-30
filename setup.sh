#!/bin/bash

# ----------------------------------------------
# Ubuntu Dev Setup Script - Ubuntu 24.04
# Automatiza a configuração de ambiente de desenvolvimento
# Autor: Arthur Felippe ;)
# ----------------------------------------------

set -e

# --------- Atualização inicial do sistema ---------
echo "\n📦 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y

# --------- Instalando utilitários básicos ---------a
echo "\n🔧 Instalando utilitários essenciais..."
sudo apt install -y git curl rsync vim htop neofetch \
  gnome-tweaks gnome-extensions-app vlc

# --------- Snap e Flatpak ---------
echo "\n📦 Instalando Snap e Flatpak..."
sudo apt install -y snapd flatpak gnome-software-plugin-flatpak

# --------- Chrome ---------
echo "\n🌐 Instalando Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# --------- VS Code ---------
echo "\n📝 Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | \
  sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] \
  https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt update
sudo apt install -y code

# --------- Extensões VS Code ---------
echo "\n🧩 Instalando extensões do VS Code..."
if command -v code &> /dev/null; then
  EXTENSIONS=(
    GitHub.copilot-chat vscode-icons-team.vscode-icons Vue.volar
    ms-azuretools.vscode-containers ms-vscode-remote.remote-containers
    ms-azuretools.vscode-docker docker.docker dracula-theme.theme-dracula
    waderyan.gitblame GitHub.copilot ecmel.vscode-html-css oderwat.indent-rainbow
    VisualStudioExptTeam.vscodeintellicode Zignd.html-css-class-completion
    ms-vscode.live-server ritwickdey.LiveServer DavidAnson.vscode-markdownlint
    bmewburn.vscode-intelephense-client MS-CEINTL.vscode-language-pack-pt-BR
    esbenp.prettier-vscode hollowtree.vue-snippets
  )
  for ext in "${EXTENSIONS[@]}"; do
    code --install-extension "$ext"
  done
else
  echo "⚠️ VS Code não encontrado. Pulei extensões."
fi

# --------- Postman ---------
echo "\n📮 Instalando Postman..."
sudo snap install postman

# --------- Docker ---------
echo "\n🐳 Instalando Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

# --------- ONLYOFFICE ---------
echo "\n📄 Instalando ONLYOFFICE..."
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | \
  sudo tee /etc/apt/sources.list.d/onlyoffice.list
wget -qO - https://download.onlyoffice.com/repo/onlyoffice.key | sudo apt-key add -
sudo apt update && sudo apt install -y onlyoffice-desktopeditors

# --------- Remmina ---------
echo "\n💻 Instalando Remmina..."
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret

# --------- AnyDesk ---------
echo "\n🧑‍💻 Instalando AnyDesk..."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | \
  sudo gpg --dearmor -o /usr/share/keyrings/anydesk.gpg
echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | \
  sudo tee /etc/apt/sources.list.d/anydesk.list > /dev/null
sudo apt update && sudo apt install -y anydesk

# --------- Spotify ---------
echo "\n🎵 Instalando Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | \
  gpg --dearmor | sudo tee /usr/share/keyrings/spotify.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | \
  sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install -y spotify-client

# --------- Bitwarden ---------
echo "\n🔐 Instalando Bitwarden..."
sudo snap install bitwarden

# --------- OBS Studio ---------
echo "\n🎥 Instalando OBS Studio..."
sudo apt install -y obs-studio

# --------- Extensões GNOME ---------
echo "\n🧩 Instalando gnome-shell-extension-installer..."

curl -Lo gnome-shell-extension-installer https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/local/bin/

EXT_IDS=(615 6 517 2087 516 435 5721 307 19)
for id in "${EXT_IDS[@]}"; do
  gnome-shell-extension-installer "$id" --yes
done

# --------- Finalização ---------
echo "\n✅ Atualizando sistema novamente..."
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y
sudo apt clean

echo "\n🎉 Instalação concluída. Reinicie sua sessão para aplicar todas as mudanças."
