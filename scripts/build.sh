#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################

MULLED="--mulled-test"

if [[ $(./buildkite/scripts/env_matrix_update.sh) = "true" ]]
then
    RANGE=""
else
    RANGE="--git-range master HEAD"
fi


if [[ $BUILDKITE_BRANCH = "master" ]]
then
    RANGE=""
    MULLED=""
fi


if [[ $OS = "Linux" ]]
then
    DOCKER="--docker"
else
    DOCKER=""
fi

bioconda-utils build recipes config.yml $RANGE $DOCKER $MULLED
