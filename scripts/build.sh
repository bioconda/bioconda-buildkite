#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################

if [[ $(./buildkite/scripts/env_matrix_update.sh) = "true" ]] || [[ $BUILDKITE_BRANCH = "master" ]]
then
    RANGE=""
else
    RANGE="--git-range master HEAD"
fi


if [[ $OS = "Linux" ]]
then
    DOCKER="--docker"
else
    DOCKER=""
fi

bioconda-utils build recipes config.yml $RANGE $DOCKER
