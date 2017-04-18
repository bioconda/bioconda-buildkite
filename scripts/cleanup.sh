#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### clean conda cache #######
conda clean --all --yes

####### clean docker cache ######
# delete stopped containers
docker container prune -f
# delete images older than a week
docker rmi $(docker images | grep " [months|weeks|years]* ago" | awk '{print $3}')
