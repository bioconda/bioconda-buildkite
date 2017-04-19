#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################

set -x
bioconda-utils build recipes config.yml --testonly --force
set +x
