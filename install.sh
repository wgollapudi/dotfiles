#!/bin/bash

##
## Dotfiles install script
##

exclude_files=(
    .gitignore
    .gitmodules
    README.md
    LICENSE
    install.sh
)

dotdir="$(realpath "$(dirname "$0")")"
overwrite_flag=0

unset force
if [ "$1" = '-f' ]
then
    force=1
fi

git ls-files --recurse-submodules | while IFS='' read -r file
do
    exclude=0
    for cur_excluded in "${exclude_files[@]}"
    do
        if [ "$file" = "$cur_excluded" ]
        then
            exclude=1
        fi
    done
    if [ "$exclude" = 0 ]
    then
        target="$HOME/$file"
        if [ -L "$target" ] || [ -e "$target" ]
        then
            overwrite_flag=1
            echo "\033[31mWarning: $target already exists.\033[0m"
        else
            dir="$(dirname "$file")"
            mkdir -p "$HOME/$dir"
            ln -vs ${force:+-f} "$dotdir/$file" "$target"
        fi
    fi
done


if [ "$overwrite_flag" -eq 1 ]
then
    echo -e "\033[31mWarning: Some files or symlinks were unable to be created. Precede with Caution.\033[0m"
fi
