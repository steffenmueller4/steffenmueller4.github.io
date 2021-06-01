@echo off

set JEKYLL_VERSION=4.2.0
set CURRENT_DIRECTORY="%cd%"

docker run --rm -v "%CURRENT_DIRECTORY%:/srv/jekyll" -p 4000:4000 -it "jekyll/jekyll:%JEKYLL_VERSION%" /bin/bash -c "bundle install && bundle exec jekyll serve --host 0.0.0.0"