#!/bin/bash
# Termux startup and Neovim setup script - MODIFIED FOR LAZYVIM, ZSH PLUGINS, & POWERLEVEL10K

# Function to check and handle errors
check_error() {
	if [ $? -ne 0 ]; then
		echo "Error occurred. Exiting..."
		exit 1
	fi
}

# Function to install a package
install_package() {
	pkg install "$1" -y || {
		echo "Error installing $1"
		exit 1
	}
	echo "$1 installed"
}

echo "TERMUX STARTUP"

# Prompt for storage access
termux-setup-storage || {
	echo "Error setting up storage"
	exit 1
}

# Change termux repository
termux-change-repo || {
	echo "Error changing repository"
	exit 1
}

echo "Updating and upgrading Termux"
pkg update -y || {
	echo "Error updating"
	exit 1
}
pkg upgrade -y || {
	echo "Error upgrading"
	exit 1
}

echo "Installing packages and dependencies"
echo "-----------------------------"

# List of packages to install (optimized for mobile)
packages="python neovim nodejs git curl openssl openssh wget gh ruby php golang rust build-essential clang vim tmux sqlite imagemagick neofetch tree nano htop proot-distro fortune cowsay cmatrix ranger"

for package in $packages; do
	install_package "$package"
done

# Mobile-specific optimizations (BASHRC - Dibiarkan tidak berubah)
echo "Setting up mobile-specific configurations..."
echo "-----------------------------------"

# Create essential directories
mkdir -p ~/bin ~/projects ~/downloads ~/scripts

cat >>~/.bashrc <<'EOF'

# ===========================================
# 🚀 MOBILE TERMUX BASH BEAUTIFICATION 🚀
# ===========================================

# Color definitions for better visual experience
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Enhanced PS1 prompt with colors and mobile-friendly info
export PS1='\[\033[01;32m\]📱 \[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '

# Mobile Termux optimizations
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Mobile shortcuts with emojis
alias projects='cd ~/projects && echo "📁 Projects directory"'
alias downloads='cd ~/downloads && echo "📥 Downloads directory"'
alias scripts='cd ~/scripts && echo "📜 Scripts directory"'
alias nv='nvim'
alias py='python'
alias pip='pip3'
alias rg='ranger' # Menambahkan alias Ranger

# Git shortcuts with visual feedback
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Mobile-friendly file operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'

# Quick navigation
alias home='cd ~ && echo "🏠 Home directory"'
alias config='cd ~/.config && echo "⚙️  Config directory"'

# System information shortcuts
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='htop'

# Mobile development helpers
alias serve='python -m http.server 8000'
alias ports='netstat -tuln'
alias myip='curl -s ifconfig.me && echo'

# Fun and useful commands
alias weather='curl -s wttr.in'
alias matrix='cmatrix'
alias cowsay='cowsay -f dragon'
alias fortune='fortune | cowsay'

# Welcome message
echo "🎉 Welcome to your beautified Termux Bash! 🎉"
echo "💡 Type 'help' for available commands"
echo ""

# Help function
help() {
    echo "=========================================="
    echo "📱 MOBILE TERMUX BASH COMMANDS 📱"
    echo "=========================================="
    echo "Navigation:"
    echo "  .., ..., ....  - Quick directory up"
    echo "  home, config    - Quick directory access"
    echo "  projects        - Go to projects folder"
    echo "  downloads       - Go to downloads folder"
    echo "  scripts         - Go to scripts folder"
    echo ""
    echo "Development:"
    echo "  nv              - Open Neovim (LazyVim)"
    echo "  rg              - Open Ranger file manager"
    echo "  py              - Run Python"
    echo "  serve           - Start HTTP server on port 8000"
    echo "  ports           - Show open ports"
    echo "  myip            - Show your IP address"
    echo ""
    echo "Git shortcuts:"
    echo "  gs, ga, gc, gp - Git status, add, commit, push"
    echo "  gl, gd, gb     - Git log, diff, branch"
    echo ""
    echo "System:"
    echo "  ll, la, l      - List files with colors"
    echo "  df, du, free   - Disk and memory usage"
    echo "  htop           - System monitor"
    echo ""
    echo "Fun:"
    echo "  weather        - Check weather"
    echo "  matrix         - Matrix effect"
    echo "  cowsay         - Cow says something"
    echo "  fortune        - Random fortune"
    echo "=========================================="
}

EOF

echo "🎨 Beautified Bash configuration with colors and mobile shortcuts!"

# --- NEOVIM LAZYVIM SETUP ---
echo "🚀 NEOVIM LAZYVIM SETUP 🚀"
# Menghapus instalasi Packer lama jika ada
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim

foldername=".config"
nvim_dir="$foldername/nvim"

cd ~

if [ ! -d "$foldername" ]; then
	echo "Membuat .config folder..."
	mkdir "$foldername" || {
		echo "Error membuat .config"
		exit 1
	}
fi

cd "$foldername" || {
	echo "Error pindah ke .config"
	exit 1
}

# Hapus folder nvim yang lama dan ganti dengan LazyVim boilerplate
if [ -d "$nvim_dir" ]; then
	echo "Folder 'nvim' yang lama ditemukan. Menghapusnya untuk instalasi LazyVim..."
	rm -rf "$nvim_dir"
fi

echo "Mengkloning konfigurasi LazyVim (Starter Template)..."
git clone https://github.com/LazyVim/starter $nvim_dir || {
	echo "Error mengkloning LazyVim Starter"
	exit 1
}
check_error

echo "LazyVim telah berhasil diunduh ke ~/.config/nvim. Jalankan 'nvim' untuk instalasi plugin pertama kali."

# Pilihan membuat Neovim sebagai editor default
echo "Would you want to make Neovim your default code editor in Termux? [Y|y|N|n]"
read -p "[y|Y|n|N]" user_input_neovim

if [ "$user_input_neovim" = "y" ] || [ "$user_input_neovim" = "Y" ]; then
	ln -s -f /data/data/com.termux/files/usr/bin/nvim ~/bin/termux-file-editor || { echo "Error creating symlink"; }
	echo "You have made Neovim your code editor"
else
	echo "You chose not to make Neovim your default code editor."
fi

# --- END MODIFIKASI NEOVIM KE LAZYVIM ---

echo "=========================================="
echo "⚠️  IMPORTANT DISCLAIMER FOR BEAUTIFICATION ⚠️"
echo "=========================================="

# Bagian T-Header dan Zsh
echo "Would you want to add beautifications to your Termux like a custom name and extra shortcuts? [Y|y|N|n]"
read -p "[y|Y|n|N]" user_input_t

echo "$user_input_t"

if [ "$user_input_t" = "y" ] || [ "$user_input_t" = "Y" ]; then
	echo "Installing T-Header specific packages and Zsh plugins..."
	echo "-----------------------------------"

	# T-Header specific packages + Zsh
	t_header_packages="fd figlet boxes gum bat logo-ls eza zsh timg fzf"

	for package in $t_header_packages; do
		install_package "$package"
	done

	# Install lolcat gem for T-Header
	echo "Installing lolcat gem for T-Header..."
	gem install lolcat || {
		echo "Error installing lolcat gem"
		exit 1
	}
	echo "lolcat gem installed"

	echo "Setting up T-Header beautification..."
	cd ~ || {
		echo "Error changing to home directory"
		exit 1
	}
	git clone https://github.com/remo7777/T-Header.git || {
		echo "Error cloning T-Header repository"
		exit 1
	}
	cd T-Header/ || {
		echo "Error changing to T-Header directory"
		exit 1
	}
	# T-Header.sh ini umumnya menginstal Oh My Zsh dan mengganti shell
	bash t-header.sh || {
		echo "Error running t-header.sh"
		exit 1
	}

	# --- START MODIFIKASI ZSH PLUGINS & THEME ---
	echo "🔌 Menginstal Powerlevel10k dan Plugin Zsh Tambahan..."

	ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom/plugins"
	ZSH_THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"
	mkdir -p "$ZSH_CUSTOM_DIR"
	mkdir -p "$ZSH_THEMES_DIR"

	# 1. Powerlevel10k (Theme)
	if [ ! -d "$ZSH_THEMES_DIR/powerlevel10k" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEMES_DIR/powerlevel10k"
		echo "Powerlevel10k diinstal."
	else
		echo "Powerlevel10k sudah ada, dilewati."
	fi

	# 2. zsh-autosuggestions (Plugin)
	if [ ! -d "$ZSH_CUSTOM_DIR/zsh-autosuggestions" ]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/zsh-autosuggestions"
		echo "zsh-autosuggestions diinstal."
	else
		echo "zsh-autosuggestions sudah ada, dilewati."
	fi

	# 3. zsh-syntax-highlighting (Plugin)
	if [ ! -d "$ZSH_CUSTOM_DIR/zsh-syntax-highlighting" ]; then
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_DIR/zsh-syntax-highlighting"
		echo "zsh-syntax-highlighting diinstal."
	else
		echo "zsh-syntax-highlighting sudah ada, dilewati."
	fi

	# 4. zsh-navigation-tool (Plugin)
	if [ ! -d "$ZSH_CUSTOM_DIR/zsh-navigation-tool" ]; then
		git clone https://github.com/zdharma-continuum/zsh-navigation-tool "$ZSH_CUSTOM_DIR/zsh-navigation-tool"
		echo "zsh-navigation-tool diinstal."
	else
		echo "zsh-navigation-tool sudah ada, dilewati."
	fi

	# Menambahkan theme dan plugin ke ~/.zshrc
	cd ~

	# Mengubah ZSH_THEME menjadi powerlevel10k/powerlevel10k
	if grep -q "ZSH_THEME=" ~/.zshrc; then
		sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
	else
		echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc
	fi

	# Mengganti baris plugins=(...)
	if grep -q "plugins=(" ~/.zshrc; then
		sed -i 's/^plugins=(.*)/plugins=(git z termux history zsh-autosuggestions zsh-syntax-highlighting zsh-navigation-tool)/' ~/.zshrc
	else
		echo "plugins=(git z termux history zsh-autosuggestions zsh-syntax-highlighting zsh-navigation-tool)" >>~/.zshrc
	fi

	# Menambahkan alias Zsh untuk mobile usage (dibiarkan tidak berubah)
	cat >>~/.zshrc <<'EOF'

# Mobile Termux optimizations for Zsh
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Mobile shortcuts
alias projects='cd ~/projects'
alias downloads='cd ~/downloads'
alias scripts='cd ~/scripts'
alias nv='nvim'
alias py='python'
alias pip='pip3'
alias rg='ranger'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Mobile-friendly file operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Quick navigation
alias home='cd ~'
alias config='cd ~/.config'

# Zsh-specific mobile optimizations
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Oh My Zsh mobile enhancements
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Memuat zsh-syntax-highlighting
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh-navigation-tool (ZNT) keybind
# Tekan Ctrl+G untuk mengaktifkan ZNT
bindkey '^g' znt-widget 

EOF

	echo "✅ Powerlevel10k dan semua plugin Zsh telah diinstal dan dikonfigurasi."
	echo "-----------------------------------"
	echo "🚨 PERHATIAN: PENTING UNTUK POWERLEVEL10K 🚨"
	echo "-----------------------------------"
	echo "Untuk melihat ikon-ikon Powerlevel10k dengan benar, Anda harus"
	echo "MENGGANTI FONT Termux Anda dengan **Nerd Font** (Misalnya: 'Hack Nerd Font')."
	echo "Jika tidak, Anda akan melihat simbol kotak-kotak."
	echo "Petunjuk: Buka Pengaturan Termux -> Style and Font -> Font. (Atau gunakan Termux:Styling)."
	echo ""
	echo "Setelah Termux di-restart, **Powerlevel10k Configuration Wizard** akan muncul secara otomatis."
	echo "Ikuti panduan tersebut untuk mengatur tampilan prompt sesuai keinginan Anda."
	echo "-----------------------------------"

else
	echo "You chose not to add beautifications to Termux."
fi
# --- END MODIFIKASI ZSH PLUGINS & THEME ---

# Mobile usage tips (dibiarkan tidak berubah)
echo "=========================================="
echo "📱 MOBILE TERMUX USAGE TIPS 📱"
echo "=========================================="
echo "1. Use Ctrl+Z to suspend processes, 'fg' to resume"
echo "2. Use 'htop' to monitor system resources"
echo "3. Use 'tree' to visualize directory structure"
echo "4. Use 'proot-distro' to run Linux distributions"
echo "5. Use 'tmux' for persistent sessions"
echo "6. Use 'nano' for quick text editing"
echo "7. Use 'git' shortcuts: gs, ga, gc, gp, gl"
echo "8. Use 'projects', 'downloads', 'scripts' to navigate"
echo "9. Use 'nv' instead of 'nvim' for faster typing"
echo "10. Use 'py' instead of 'python' for faster typing"
echo "11. Use 'rg' instead of 'ranger' for faster typing"
echo ""
echo "🎨 BASH BEAUTIFICATION FEATURES:"
echo "   - Type 'help' for a complete command reference"
echo "   - Colorized output for better readability"
echo "   - Enhanced prompt with emojis and colors"
echo "   - Fun commands: weather, matrix, cowsay, fortune"
echo "   - Development helpers: serve, ports, myip"
echo "   - Visual feedback for directory changes"
echo ""
if [ "$user_input_t" = "y" ] || [ "$user_input_t" = "Y" ]; then
	echo "🔧 ZSH/OH-MY-ZSH FEATURES:"
	echo "   - Theme **Powerlevel10k** untuk tampilan yang canggih."
	echo "   - Tab completion is enhanced with Oh My Zsh"
	echo "   - **Auto-suggestions** dan **syntax highlighting**"
	echo "   - **Zsh Navigation Tool (ZNT)** diakses dengan **Ctrl + G**"
	echo ""
fi
echo "💡 Pro tip: Pin Termux to your recent apps for quick access!"
echo "=========================================="

echo "Happy hacking!!! 😊😊⚡⚡⚡😎😎"
