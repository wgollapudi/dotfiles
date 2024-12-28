# Walker`s dotfiles

Dotfiles are how you configure and personalize your system. These are mine

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
After installation, reload your shell:
```bash
source ~/.bash_profile
```
Don't worry if you encounter a Warning, just move your existing files elsewhere and run the installation script again, it will take care of everything.

## Acknowledgements
These files are esentially a modified fork of [Kian Kasad`s](https://github.com/kdkasad) excellent [dotfiles](https://github.com/kdkasad/dotfiles). A lot (most) of this code is copied or inspired from his work / our conversations.

I'm planning on moving to zsh eventually... but that's a lot of work I could put off instead.
