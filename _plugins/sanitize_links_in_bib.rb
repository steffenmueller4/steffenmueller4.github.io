# Sanitize jekyll-scholar links in bibliography.
# See also: https://github.com/m-pilia/m-pilia.github.io/blob/source/_plugins/unescape_cls_html.rb
require 'cgi'
require 'citeproc/ruby'

class CiteProc::Ruby::Formats::Html
  def prefix
    CGI.unescape_html options[:prefix]
  end

  def suffix
    CGI.unescape_html options[:suffix]
  end
end