#!/bin/bash


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

curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-$OS-x86_64.sh
sudo bash Miniconda3-latest-$tag-x86_64.sh -b -p `pwd`/.miniconda
export PATH=.miniconda/bin:$PATH

./simulate-travis.py --set-channel-order
./simulate-travis.py --install-requirements
