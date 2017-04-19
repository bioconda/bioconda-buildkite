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

if [[ "$BUILDKITE_PULL_REQUEST" = "false" ]]
then
    COMMENT=""
else
    COMMENT="--push-comment --pull-request $BUILDKITE_PULL_REQUEST"
fi

set -x
bioconda-utils lint recipes config.yml $COMMENT --git-range master HEAD
set +x
