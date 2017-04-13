#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################


if [[ $(.buildkite/scripts/env_matrix_update.sh) = "true" ]]
then
    RANGE=""
else
    RANGE="--git-range master HEAD"
fi


if [[ $OS = "Linux" ]]
then
    DOCKER="--docker"
    MULLED="--mulled-test"
else
    DOCKER=""
    MULLED=""
fi


if [[ $BUILDKITE_BRANCH = "master" ]]
then
    RANGE=""
    MULLED=""
fi



set -x
bioconda-utils build recipes config.yml $RANGE $DOCKER $MULLED
set +x
conda clean --all --yes
