# 🚀 Termux Mobile Development Environment Setup 📱

Ini adalah skrip *bootstrapping* Termux yang didesain untuk mengatur lingkungan pengembangan yang kaya fitur dan optimal untuk perangkat *mobile*.

Skrip ini secara otomatis menginstal alat-alat penting dan mengonfigurasi *shell* Zsh (dengan **Powerlevel10k** dan plugin) serta editor **Neovim** (dengan *distribution* **LazyVim**).

---

## ✨ Fitur Utama

* **Zsh Default Shell:** Mengubah *shell* default menjadi Zsh.
* **Powerlevel10k Theme:** Menginstal dan mengonfigurasi tema Zsh yang canggih dan cepat.
* **Zsh Plugins:** Menginstal `zsh-autosuggestions`, `zsh-syntax-highlighting`, dan `zsh-navigation-tool` (ZNT).
* **LazyVim (Neovim):** Menginstal *starter configuration* LazyVim untuk pengalaman Neovim yang siap pakai, tanpa memerlukan Packer.
* **Essential Tools:** Instalasi paket penting seperti `git`, `curl`, `wget`, `rust`, `ranger`, dan `openssh`.
* **Beautification:** Menggunakan `T-Header` untuk tampilan terminal yang lebih menarik.

---

## 📦 Daftar Paket yang Diinstal

| Kategori | Paket | Keterangan |
| :--- | :--- | :--- |
| **Editor** | `neovim` | Editor kode utama. Dikonfigurasi dengan **LazyVim**. |
| **Shell** | `zsh` | *Shell* default, diperkuat oleh **Oh My Zsh** & **Powerlevel10k**. |
| **Utilities** | `curl`, `wget` | Alat penting untuk transfer data. |
| **VCS** | `git` | Sistem kontrol versi. |
| **Development** | `rust`, `golang`, `php`, `python`, `nodejs` | Bahasa pemrograman utama dan runtime. |
| **System** | `openssh` | Untuk akses jarak jauh (Port 8022). |
| **System Tools** | `tmux`, `htop`, `ranger`, `neofetch`, `tree` | Tools manajemen sesi, monitoring, file manager, dll. |
| **Build Tools** | `build-essential`, `clang` | Alat yang diperlukan untuk mengkompilasi kode. |

---

## ⚙️ Cara Instalasi

1.  **Buka Termux** dan pastikan Termux sudah diinstal di perangkat Anda.
2.  **Buat file** `setup.sh` dan tempelkan konten skrip ke dalamnya.

    ```bash
    pkg update -y && pkg install git -y
    git clone [https://github.com/URL_REPO_ANDA/termux-config.git](https://github.com/URL_REPO_ANDA/termux-config.git) # Ganti dengan URL repo Anda
    cd termux-config
    chmod +x setup.sh
    ./setup.sh
    ```
    *(Ganti baris `git clone` di atas jika Anda hanya menyimpan skrip secara lokal)*

3.  **Ikuti Petunjuk:** Skrip akan meminta izin akses penyimpanan dan konfirmasi untuk instalasi beautification (`T-Header`).
4.  **RESTART Termux:** Setelah skrip selesai, **TUTUP dan BUKA KEMBALI** aplikasi Termux untuk memuat Zsh, Powerlevel10k, dan plugin.

---

## 🛠️ Konfigurasi Pasca-Instalasi

### 1. 🎨 Powerlevel10k (P10k)

Setelah Termux di-restart:

* **Ganti Font:** Untuk melihat ikon Powerlevel10k dengan benar, Anda **WAJIB** mengganti font Termux Anda ke **Nerd Font** (misalnya, *Hack Nerd Font*).
* **Wizard Konfigurasi:** Powerlevel10k Wizard (`p10k configure`) akan dimulai secara otomatis. Ikuti langkah-langkahnya untuk memilih gaya *prompt* yang Anda inginkan.

### 2. 💻 LazyVim (Neovim)

* Jalankan Neovim pertama kali dengan perintah `nvim` atau alias `nv`.
* LazyVim akan mendeteksi instalasi dan mengunduh semua plugin yang diperlukan. Proses ini mungkin memakan waktu beberapa menit, tergantung koneksi Anda.

### 3. 🔌 Zsh Plugins

Plugin Zsh sudah terpasang dan siap digunakan:

| Plugin | Fungsi | Keybind Utama |
| :--- | :--- | :--- |
| `zsh-autosuggestions` | Menyediakan saran perintah berdasarkan riwayat. | **Panah Kanan** (untuk menerima saran) |
| `zsh-syntax-highlighting` | Memberikan *highlight* pada perintah yang valid/tidak valid. | Otomatis |
| `zsh-navigation-tool` | Antarmuka grafis untuk menjelajahi riwayat perintah. | **Ctrl + G** |

### 4. 🌐 Akses SSH

OpenSSH diinstal dan berjalan pada port non-standar:

* **Port:** `8022`
* **Mulai Server:** `sshd`
* **Lihat IP:** `ifconfig`
* **Atur Password:** `passwd` (untuk mengatur kata sandi login Termux)

---

## ⚙️ Alias dan Shortcut yang Berguna

Skrip ini menambahkan beberapa alias dan fungsi yang berguna ke `~/.bashrc` (jika Anda kembali ke Bash) dan `~/.zshrc`:

| Alias | Perintah | Deskripsi |
| :--- | :--- | :--- |
| `nv` | `nvim` | Membuka Neovim. |
| `rg` | `ranger` | Membuka *file manager* Ranger. |
| `gs` | `git status` | Melihat status Git. |
| `ga` | `git add .` | Menambahkan semua perubahan ke Git. |
| `projects` | `cd ~/projects` | Pindah cepat ke folder proyek. |
| `serve` | `python -m http.server 8000` | Memulai server HTTP sederhana. |
| `top` | `htop` | Memonitor sistem. |
| `weather` | `curl -s wttr.in` | Melihat cuaca. |
| `matrix` | `cmatrix` | Efek terminal "Matrix". |
