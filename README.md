# Walker`s dotfiles

Dotfiles are how you configure and personalize your system. These are mine.

Because dotfiles are hidden by default, you might want to use `ls -A` when looking through the repository.

## Installation
1. **Clone the Repository**:
```bash
git clone "https://github.com/wgollapudi/dotfiles" "~/.dotfiles"
```

2. **Run the Installation Script**:

Navigate to the repository and run the install script:
```bash
cd ~/.dotfiles
bash install.sh
```

3. **Source the Shell Configuration**:

After installation, reload your shell;
```bash
source ~/.bash_profile
```
Don't worry if you encounter a Warning, just move your existing files elsewhere and run the installation script again, it will take care of everything.

## Acknowledgements
These files are esentially a modified fork of [Kian Kasad`s](https://github.com/kdkasad) excellent [dotfiles](https://github.com/kdkasad/dotfiles). A lot (most) of this code is copied or inspired from his work / our conversations.

I'm planning on moving to zsh eventually... but that's a lot of work I could put off instead.

## Bonus - Neovim workaround
If you're working on a Debian or Ubuntu machine (like me) you may notice that my Neovim configuration is broken.

Running `:checkhealth` will then probably reveal that treesitter requires Neovim 0.10.\*, while you are stuck with version 0.9.\*.

This is because the `apt` (and `ppa:neovim-ppa`) maintainers are a few months behind and still recognize Neovim 0.9.\* as the latest stable version.

To circumvent this, I downloaded the bianarys myself. Because this is meant to be a portable download, I used a tarball, but I would also urge others look into the appimage installation 

<div style="
  border-left: 4px solid #ff4d4f;
  padding: 0.8em 1.2em;
  background-color: #fff5f5;
  border-radius: 4px;
  margin: 1em 0;
">
  <strong style="color: #cf1322;">Warning:</strong>
  <p style="margin: 0.2em 0 0;">
    This installation of Neovim is considered unstable by Debian and Ubuntu, I wouldn't reccomend proceeding if you are working with mission critical systems.
  </p>
</div>

### Installation

1. **Download the Latest (stable) Neovim Tarball**

Go to Neovim's [Release Page](https://github.com/neovim/neovim/releases) and find the latest stable release. At the bottom, under "Assets", look for a link to a file named `nvim-linux64.tar.gz`. Then, use that link to download the Tarball. I downloaded Neovim 0.11.3, which made the link to my tarball [https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz](https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz).
```bash
cd ~
mkdir tarballs
cd tarballs
wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
```

2. **Extract the Tarball**

Once the tarball is downloaded
```bash
tar xzf nvim-linux-x86_64.tar.gz
```
This creates a folder named `nvim-linux-x86_64` (name may vary slighty by version)

### If you are root
3a. **Move Neovim to a System Directory**

`/usr/local` is the standard location for user-installed software. Some may prefer `/opt`, though.
```bash
sudo mv nvim-linux-x86_64 /usr/local/nvim
```

3b. **Create a Symlink (So You Can Run `nvim`)**

Link the `nvim` executeable into a directory that's already in your `PATH`, usually `/usr/local/bin`.
```bash
sudo -ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim
```
If another symlink already exists, run the command with the `-f` (force) flag

### If you are not root

3a. **Move the Neovim Binary's to `PATH`**
Move your extracted binaries to a library directory
```bash
cd ~
mkdir library
mv tarballs/nvim-linux64 library/nvim-linux64
```
Then, open your shell configuration (e.g. `~/.bashrc`, `~/.zshrc`) and add the following line
```bash
export PATH=$HOME/library/nvim-linux-86_64/bin:$PATH
```
Reload your shell

4. **Verify the Installation**

Now you should be able to run `nvim` from anywhere in your terminal.
Run
```bash
nvim --version
```
to confirm your installation was succesful.
