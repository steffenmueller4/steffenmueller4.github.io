#!/bin/bash
set +eux

CURRENT_DIRECTORY=$(pwd)

# Jekyll requires a rootful podman machine: podman machine set --rootful
#podman machine set --rootful
docker run -it -p 4000:4000 -v $(pwd):/site bretfisher/jekyll-serve