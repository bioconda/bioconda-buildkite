#!/bin/bash
set -euo pipefail


####### clean conda cache #######
conda clean --all --yes

####### clean docker cache ######
docker system prune -f
