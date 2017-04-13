#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### determine OS #############
OS=Linux
if [[ $(uname -s) = "Darwin" ]]
then
    OS=MacOSX
fi


####### bash-only checks #########

for dir in . recipes
do
    if [[ -e $dir/meta.yaml ]]
    then
        echo "Recipe $dir/meta.yaml found in invalid location."
        echo "Recipes must be stored in a subfolder of the recipes directory."
        exit 1
    fi
done


####### Setup conda ##############

OLD_MINICONDA_VER=$(`cat .miniconda/version.txt 2> /dev/null` || echo "")

if [[ "$OLD_MINICONDA_VER" != "$MINICONDA_VER" ]]
then
    curl -O https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VER-$OS-x86_64.sh
    bash Miniconda3-$MINICONDA_VER-$OS-x86_64.sh -b -p `pwd`/.miniconda
    echo $MINICONDA_VER > .miniconda/version.txt
fi
export PATH=.miniconda/bin:$PATH

./simulate-travis.py --set-channel-order
./simulate-travis.py --install-requirements
