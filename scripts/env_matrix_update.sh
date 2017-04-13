#!/bin/bash

git diff --exit-code --name-only $RANGE scripts/env_matrix.yml
