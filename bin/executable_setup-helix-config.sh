#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <rust|mvn|gradle>"
    exit 1
fi

case "$1" in
rust | mvn | gradle)
    config_type="$1"
    ;;
*)
    echo "Error: Invalid argument. Must be one of: rust, mvn, gradle"
    exit 1
    ;;
esac

mkdir -p .helix

echo "ln -sf ${HOME}/src/.helix/config-${config_type}.toml .helix/config.toml"
ln -sf "${HOME}"/src/.helix/config-"${config_type}".toml .helix/config.toml
