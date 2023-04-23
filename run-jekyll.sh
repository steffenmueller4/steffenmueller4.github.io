#!/bin/bash
set +eux

JEKYLL_VERSION="4.2.2"
CURRENT_DIRECTORY=$(pwd)

# Jekyll requires a rootful podman machine: podman machine set --rootful
podman run --rm -v "${CURRENT_DIRECTORY}:/srv/jekyll" -p 4000:4000 -e JEKYLL_UID=501 -e JEKYLL_GID=20 -it "jekyll/jekyll:${JEKYLL_VERSION}" /bin/bash -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"