# Expose `hero_image` to jekyll-seo-tag (which only reads `image`) so that
# og:image / twitter:image point to the hero image in social link previews
# (LinkedIn, Slack, etc.) instead of crawlers picking the first <img> in the body.
Jekyll::Hooks.register :posts, :pre_render do |post|
  hero = post.data["hero_image"]
  post.data["image"] ||= hero if hero
end
