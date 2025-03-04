#!/bin/bash

if [ ! -v GITHUB_TOKEN ]; then
    export GITHUB_TOKEN=$(gh auth token)
fi

