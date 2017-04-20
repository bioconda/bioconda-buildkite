#!/bin/bash
set -euo pipefail


####### lint recipes #############

if [[ $(.buildkite/scripts/env_matrix_update.sh) = "true" ]]
then
    # do not lint
    exit 0
fi

if [[ "$BUILDKITE_PULL_REQUEST" = "false" ]]
then
    COMMENT_ARG=""
else
    COMMENT_ARG="--push-comment --pull-request $BUILDKITE_PULL_REQUEST"
fi

bioconda-utils lint recipes config.yml $COMMENT_ARG --git-range master HEAD
