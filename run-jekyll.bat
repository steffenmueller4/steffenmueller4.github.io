@echo off

set CURRENT_DIRECTORY="%cd%"

docker build -t jekyll-blog .
docker run --rm -v "%CURRENT_DIRECTORY%:/site" -p 4000:4000 -p 35729:35729 jekyll-blog