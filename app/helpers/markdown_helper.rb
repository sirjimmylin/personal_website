module MarkdownHelper
  include ActionView::Helpers::SanitizeHelper

  def markdown(text)
    return "" unless text.present?

    # 1. Configure the HTML Renderer
    renderer = Redcarpet::Render::HTML.new(
      filter_html: false,     # <--- CHANGE THIS to false so your <div> tags work!
      hard_wrap: true, 
      link_attributes: { rel: "nofollow noopener noreferrer", target: "_blank" }
    )

    # 2. Configure the Parser (Enable Tables & Code Blocks here!)
    extensions = {
      autolink: true,
      tables: true,           # <--- ENABLES TABLES
      fenced_code_blocks: true, # <--- ENABLES CODE BLOCKS (```ruby ...)
      strikethrough: true,
      superscript: true,
      highlight: true
    }

    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # 3. Render and sanitize to prevent unsafe HTML injection
    sanitize(markdown.render(text), tags: markdown_allowed_tags, attributes: markdown_allowed_attributes)
  end

  private

  def markdown_allowed_tags
    %w[
      a abbr b blockquote br code del div em h1 h2 h3 h4 h5 h6 hr i img li ol p pre
      span strong sup sub table tbody td th thead tr ul
    ]
  end

  def markdown_allowed_attributes
    %w[
      alt class href id rel src target title width height
    ]
  end
end
