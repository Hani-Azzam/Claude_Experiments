#!/bin/bash
# Installs the tools this project needs. Run at the start of every new session.
set -e

if ! command -v osmium >/dev/null; then
  apt-get update -qq
  apt-get install -y osmium-tool
fi

# JavaScript dependencies from package.json (e.g. leaflet)
npm install

# OSM data (not committed; too large for git). Geofabrik's HTTPS endpoint is
# unreachable from the cloud sandbox, so use the OSM France mirror instead.
mkdir -p data
if [ ! -f data/israel_and_palestine.osm.pbf ]; then
  curl -sSfL --retry 3 -o data/israel_and_palestine.osm.pbf \
    https://download.openstreetmap.fr/extracts/asia/israel_and_palestine.osm.pbf
fi
if [ ! -f data/yavne.osm.pbf ]; then
  osmium extract -b 34.66,31.835,34.77,31.93 --set-bounds \
    data/israel_and_palestine.osm.pbf -o data/yavne.osm.pbf
fi
