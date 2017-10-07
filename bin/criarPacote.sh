#!/bin/bash

export EMAIL="dev@pandorgalinux.com.br"
export DEBFULLNAME="Pandorga GNU/Linux Development Team"

BASE_DIR="/opt/pandorga//packages/"

mkdir -p "$BASE_DIR/$1-$2"
cd "$BASE_DIR/$1-$2"
dh_make --native
