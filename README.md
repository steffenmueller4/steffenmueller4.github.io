# steffenmueller4.github.io

Theme is based on: [samarsault.com](https://samarsault.com)

## Development

### Using Docker (recommended)

Build the Docker image and run the site locally:

```bash
docker build -t jekyll-blog .
docker run --rm -v "$(pwd):/site" -p 4000:4000 -p 35729:35729 jekyll-blog
```

Or simply run:

```bash
./run-jekyll.sh
```

The site will be available at `http://localhost:4000` with LiveReload enabled (port 35729).

### Without Docker

To set up your environment to develop this theme, run `bundle install`.

Run `bundle exec jekyll serve` and open your browser at `http://localhost:4000`. As you make modifications, the site will regenerate and you should see the changes after a refresh.

### Deployment

The site is automatically built and deployed to GitHub Pages via GitHub Actions on every push to `master`.
