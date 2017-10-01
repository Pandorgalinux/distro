#!/bin/bash

export EMAIL="distro@pandorgalinux.com.br"
export DEBFULLNAME="Pandorga GNU/Linux Team"

BASE_DIR="/opt/pandorga/distro/packages/"

mkdir -p "$BASE_DIR/$1-$2"
cd "$BASE_DIR/$1-$2"
dh_make --native
