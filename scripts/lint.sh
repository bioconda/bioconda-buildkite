#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'


####### lint recipes #############

if [[ $(.buildkite/scripts/env_matrix_update.sh) = "true" ]]
then
    # do not lint
    exit 0
fi

bioconda-utils lint recipes config.yml --git-range master HEAD --push-comment --pull-request $BUILDKITE_PULL_REQUEST
