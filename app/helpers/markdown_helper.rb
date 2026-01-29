module MarkdownHelper
  def markdown(text)
    return "" unless text.present?

    # Options for Redcarpet
    options = {
      filter_html:     false, # Allow HTML (needed for your interactive buttons)
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # Sanitize helps prevent XSS attacks while allowing specific tags
    sanitize(markdown.render(text), tags: %w(h1 h2 h3 div p span a ul ol li b i strong em pre code table tr th td img br iframe))
  end
end