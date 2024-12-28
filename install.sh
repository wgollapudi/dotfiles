#!/bin/bash

##
## Dotfiles install script
##

exclude_files=(
    .gitignore
    README.md
    LICENSE
    install.sh
)

dotdir="$(realpath "$(dirname "$0")")"
declare -a warnings=()

unset force
if [ "$1" = '-f' ]
then
    force=1
fi

git ls-files --recurse-submodules | while IFS='' read -r file; do
    exclude=0
    for ex_file in "${exclude_files[@]}"; do
        if [ "$file" = "$ex_file" ]; then
            exclude=1
            break
        fi
    done

    if [ "$exclude" -eq 0 ]; then
        target="$HOME/$file"
        if [ -e "$target" ] || [ -L "$target" ]; then
            warnings+=("Warning: $target already exists. Unable to create symlink.")
        else
            dir="$(dirname "$file")"
            mkdir -p "$HOME/$dir"
            ln -vs ${force:+-f} "$dotdir/$file" "$target"
        fi
    fi
done


if [ "${#warnings[@]}" -gt 0 ]; then
    echo
    echo -e "\033[31mSummary of warnings:\033[0m"
    for w in "${warnings[@]}"; do
        echo -e "\033[31mWarning: Some files or symlinks were unable to be created. Precede with Caution.\033[0m"
    done
fi
