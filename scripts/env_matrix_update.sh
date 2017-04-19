#!/bin/bash

git diff --exit-code --name-only master...HEAD scripts/env_matrix.yml

if [[ $? -eq 1 ]]
then
    echo true
else
    echo false
fi
