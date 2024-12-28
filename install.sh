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
mapfile -t files < <(git ls-files --recurse-submodules)

unset force
if [ "$1" = '-f' ]
then
    force=1
fi

for file in "${files[@]}"; do
    exclude=0
    for ex_file in "${exclude_files[@]}"; do
        if [ "$file" = "$ex_file" ]; then
            exclude=1
            break
        fi
    done

    if [ "$exclude" -eq 0 ]; then
        target="$HOME/$file"
        if [ -e "$target" ]; then
            warning="Warning: $target already exists. Unable to create symlink."
            echo -e "\033[31m$warning\033[0m"
            warnings+=("$warning")
        else
            dir="$(dirname "$file")"
            mkdir -p "$HOME/$dir"
            ln -vs ${force:+-f} "$dotdir/$file" "$target"
        fi
    fi
done


if [ "${#warnings[@]}" -gt 0 ]; then
    echo
    echo -e "Summary of warnings:"
    for w in "${warnings[@]}"; do
        echo -e "\033[31m$w\033[0m"
    done
fi
