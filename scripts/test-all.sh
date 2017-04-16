#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################

set -x
bioconda-utils build recipes config.yml --testonly --force 2>&1 | tee test.log
set +x

########## cleanup ###############
.buildkite/scripts/cleanup.sh
