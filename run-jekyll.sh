#!/bin/bash
set +eux

CURRENT_DIRECTORY=$(pwd)

docker build -t jekyll-blog .
docker run --rm -v "$(pwd):/site" -p 4000:4000 -p 35729:35729 jekyll-blog