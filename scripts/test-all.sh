#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### run tests ################

bioconda-utils build recipes config.yml --testonly --force
