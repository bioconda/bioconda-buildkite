#!/bin/bash
set -euo pipefail


####### run tests ################


if [[ $(.buildkite/scripts/env_matrix_update.sh) = "true" ]]
then
    RANGE_ARG=""
else
    RANGE_ARG="--git-range master HEAD"
fi


if [[ $OS = "Linux" ]]
then
    DOCKER_ARG="--docker"
    MULLED_ARG="--mulled-test"
else
    DOCKER_ARG=""
    MULLED_ARG=""
fi


if [[ $BUILDKITE_BRANCH = "master" ]]
then
    RANGE_ARG=""
    # TODO add upload args.
    if [[ $OS = "Linux" ]]
    then
        UPLOAD_ARG=""
    else
        UPLOAD_ARG=""
    fi
fi

# TODO temporarily deactivate --mulled-test because it creates a "build" directory with root rights.
# This directory cannot be cleaned up by buildkite-agent!
MULLED_ARG=""

set -x
bioconda-utils build recipes config.yml $RANGE_ARG $DOCKER_ARG $MULLED_ARG $UPLOAD_ARG
set +x
