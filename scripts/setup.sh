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
export OS


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

MINICONDA_PATH=/tmp/.miniconda

OLD_MINICONDA_VER=$(cat $MINICONDA_PATH/version.txt 2> /dev/null || echo "")
echo "Miniconda version: $OLD_MINICONDA_VER"

if [[ "$OLD_MINICONDA_VER" != "$MINICONDA_VER" ]]
then
    echo "updating Miniconda version: $MINICONDA_VER"
    curl -O https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VER-$OS-x86_64.sh
    bash Miniconda3-$MINICONDA_VER-$OS-x86_64.sh -b -p $MINICONDA_PATH
    echo $MINICONDA_VER > $MINICONDA_PATH/version.txt
fi
export PATH=$MINICONDA_PATH/bin:$PATH

# wipe previous config
rm -f $HOME/.condarc

# set channel order
./simulate-travis.py --set-channel-order

# install requirements
conda install -y --file https://raw.githubusercontent.com/bioconda/bioconda-utils/$BIOCONDA_UTILS_TAG/bioconda_utils/bioconda_utils-requirements.txt
pip uninstall -y bioconda-utils
pip uninstall -y bioconda-utils
#pip install --upgrade --force-reinstall --no-deps git+https://github.com/bioconda/bioconda-utils.git@$BIOCONDA_UTILS_TAG

# use conda-bld directories as index
conda index $MINICONDA_PATH/conda-bld/linux-64 $MINICONDA_PATH/conda-bld/osx-64
