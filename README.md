# 🚀 Ubuntu Dev Setup Script - Ubuntu 24.04

## Script completo para automatizar a instalação de um ambiente de desenvolvimento moderno no **Ubuntu 24.04**.

> Desenvolvido por [Arthur Felippe (Thur17)](https://github.com/Thur17) 😉

---

## 📌 O que este script faz?

### Este script automatiza **todo o processo de preparação de um sistema Ubuntu para desenvolvimento**, desde a atualização do sistema até a instalação de ferramentas populares de desenvolvimento, produtividade e suporte remoto.

---

## 🧾 Passo a passo do que é feito

### 1. 🔄 Atualização inicial do sistema
- Executa: `apt update`, `upgrade`, `full-upgrade`, `autoremove`, `clean`

### 2. 🔧 Instalação de utilitários essenciais
- `git`, `curl`, `rsync`, `vim`, `htop`, `neofetch`
- `gnome-tweaks`, `gnome-extensions-app`, `vlc`

### 3. 📦 Suporte a Snap e Flatpak
- `snapd`, `flatpak`, `gnome-software-plugin-flatpak`

### 4. 🌐 Google Chrome
- Download e instalação direta do `.deb`

### 5. 📝 Visual Studio Code
- Repositório oficial da Microsoft
- Instalação via APT

#### 🔌 Extensões VS Code instaladas:
- GitHub Copilot & Chat, Prettier, Dracula Theme, Docker, Live Server
- Vue.js, HTML/CSS helpers, Git Blame, Markdown Linter, PHP (Intelephense)
- Icons, Snippets, Language Pack PT-BR, Remote Containers, entre outras

### 6. 📮 Postman
- Instalação via Snap

### 7. 🗃️ MySQL Server + Workbench
- Instalação via APT

### 8. 🐳 Docker
- Repositório oficial da Docker
- Instalação: `docker-ce`, `docker-ce-cli`, `containerd.io`
- Adiciona o usuário atual ao grupo `docker`

### 9. 📄 ONLYOFFICE
- Repositório oficial + instalação do editor de documentos

### 10. 💻 Remmina
- Acesso remoto com suporte a RDP, VNC, Secrets

### 11. 🧑‍💻 AnyDesk
- Repositório oficial + instalação

### 12. 🎵 Spotify
- Repositório oficial + instalação via APT

### 13. 🔐 Bitwarden
- Instalação via Snap

### 14. 🎥 OBS Studio
- Instalação via APT

### 15. 🧩 Extensões GNOME
- Instala automaticamente as seguintes extensões GNOME:

  IDs: `615`, `6`, `517`, `2087`, `516`, `435`, `5721`, `307`, `19`

---

## ✅ Finalização
- Atualiza o sistema novamente
- Limpa pacotes obsoletos
- Mensagem final: instalação concluída e instrução para reiniciar a sessão

---

## 💡 Como executar

### Opção 1 – via `curl`
```bash
bash <(curl -s https://raw.githubusercontent.com/Thur17/ubuntu-dev-setup/main/setup.sh)
```
### Opção 2 – clonando o repositório

```bash
git clone https://github.com/Thur17/ubuntu-dev-setup.git
cd ubuntu-dev-setup
chmod +x setup.sh
./setup.sh
```

## ⚠️ Requisitos

- Ubuntu 24.04 LTS  
- Acesso sudo  
- Conexão com a internet  

---

## 🧪 Testado em:

- ✅ Ubuntu Desktop 24.04 LTS (instalação limpa)

---

## 📬 Contato

- GitHub: [@Thur17](https://github.com/Thur17)  
- Email: arthurthur17@gmail.com

---

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

## 🙌 Contribua

Sugestões, melhorias ou novas ferramentas são bem-vindas!  
Abra uma issue ou envie um pull request para colaborar!

---