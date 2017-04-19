#!/bin/bash

####### activate strict mode #####
set -euo pipefail
IFS=$'\n\t'

####### clean conda cache #######
conda clean --all --yes

####### clean docker cache ######
# delete stopped containers
docker container prune -f
docker system prune -f
# delete images older than a week
IMAGES=$(docker images | (grep " [months|weeks|years]* ago" || true) | awk '{print $3}')
if [[ "$IMAGES" != "" ]]
then
    docker rmi $IMAGES
fi
