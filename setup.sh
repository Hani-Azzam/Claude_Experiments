#!/bin/bash
# Installs the tools this project needs. Run at the start of every new session.
set -e

if ! command -v osmium >/dev/null; then
  apt-get update -qq
  apt-get install -y osmium-tool
fi

# JavaScript dependencies from package.json (e.g. leaflet)
npm install
