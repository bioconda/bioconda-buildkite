#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### clean conda cache #######
conda clean --all --yes

####### clean docker cache ######
docker system prune -f
