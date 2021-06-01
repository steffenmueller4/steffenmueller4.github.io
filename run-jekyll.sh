#!/bin/bash
set +eux

JEKYLL_VERSION="4.2.0"
CURRENT_DIRECTORY=$(pwd)

docker run --rm -v "${CURRENT_DIRECTORY}:/srv/jekyll" -p 4000:4000 -it "jekyll/jekyll:${JEKYLL_VERSION}" /bin/bash -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"