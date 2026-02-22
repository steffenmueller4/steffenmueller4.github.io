# AGENTS.md - Agentic Coding Guidelines

## Project Overview

This is a **Jekyll static site** (v4.2.2) using the plainwhite theme with jekyll-scholar for academic bibliographies. The site is deployed to GitHub Pages.

## Build / Development Commands

### Local Development

```bash
# Install dependencies
bundle install

# Serve site locally (http://localhost:4000)
bundle exec jekyll serve

# Alternative: using Docker (port 4000)
./run-jekyll.sh

# Build for production (outputs to _site/)
bundle exec jekyll build
```

### Testing

There are **no automated tests** for this static site. To verify changes:
1. Run `bundle exec jekyll serve` and manually check the output
2. Verify the built site in `_site/` directory
3. Check that bibliography renders correctly at `/publications/`

### Deployment

- **Automatic**: GitHub Actions on push to `master` branch (`.github/workflows/github-pages.yml`)
- **Manual**: Build locally with `bundle exec jekyll build` and deploy `_site/` contents

## Code Style Guidelines

### General Principles

- This is primarily a **content-driven static site**, not an application
- Modify **templates** (`_layouts/`, `_includes/`) for structural changes
- Modify **styles** (`_sass/`, `assets/`) for visual changes
- Modify **configuration** (`_config.yml`) for site settings

### Ruby (Plugins)

The project has one Ruby plugin at `_plugins/sanitize_links_in_bib.rb`.

**Style conventions:**
- Use 2 spaces for indentation (Ruby standard)
- Follow standard Ruby naming conventions (snake_case for variables/methods, CamelCase for classes)
- Use `require` for library imports at top of file
- Include comments explaining non-obvious logic (see existing plugin for example)

Example:
```ruby
# Comment describing the plugin's purpose
require 'cgi'
require 'citeproc/ruby'

class CiteProc::Ruby::Formats::Html
  def prefix
    CGI.unescape_html options[:prefix]
  end
end
```

### YAML (Configuration)

Used in `_config.yml` and bibliography files.

**Style conventions:**
- Use 2 spaces for indentation
- Use lowercase keys
- Use quoted strings for values with special characters
- Prefer explicit formatting over anchors/aliases

### Liquid (Templates)

Used in `_layouts/`, `_includes/`, and HTML files.

**Style conventions:**
- Use descriptive variable names
- Add comments for complex logic: `{% comment %} ... {% endcomment %}`
- Use whitespace control: `{%- ... -%}` to trim whitespace
- Prefer filters over direct variable manipulation

### HTML

**Style conventions:**
- Use 2 spaces for indentation
- Use lowercase tags and attributes
- Use double quotes for attributes
- Include closing tags (no self-closing HTML tags)

### CSS/SCSS

Located in `_sass/` and `assets/`.

**Style conventions:**
- Use SCSS (Sass) for new stylesheets
- Follow BEM naming for complex components: `.block__element--modifier`
- Use CSS variables for theme colors
- Group related styles

### File Organization

- `_posts/` - Blog posts (Markdown), named `YYYY-MM-DD-title.md`
- `_bibliography/` - Academic references (BibTeX `.bib` files)
- `assets/` - Images, CSS, JavaScript
- `_includes/` - Reusable partials
- `_layouts/` - Page templates

### Error Handling

- Jekyll build errors: Check `_config.yml` syntax (YAML is strict)
- Plugin errors: Ensure gems in Gemfile are installed (`bundle install`)
- Broken links: Use `bundle exec jekyll build` output to identify issues

### Common Tasks

| Task | Command/Location |
|------|------------------|
| Add blog post | Create file in `_posts/` with date prefix |
| Add publication | Add to `_bibliography/references.bib` |
| Change theme colors | Edit `_sass/` files or add custom CSS |
| Modify navbar | Edit `header_pages` in `_config.yml` |
| Enable dark mode | Set `dark_mode: true` in `_config.yml` |

### Important Files

- `_config.yml` - Main configuration (67 lines)
- `_plugins/sanitize_links_in_bib.rb` - Bibliography link sanitizer
- `_bibliography/references.bib` - Academic citations
- `_posts/` - Blog post content
