#!/bin/bash

if [ ! -v GITHUB_TOKEN ]; then
    GITHUB_TOKEN=$(gh auth token)
    export GITHUB_TOKEN
fi

