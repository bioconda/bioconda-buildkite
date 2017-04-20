#!/bin/bash
set -euo pipefail


####### run tests ################

set -x
bioconda-utils build recipes config.yml --testonly --force
set +x
