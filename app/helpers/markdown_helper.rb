module MarkdownHelper
  def markdown(text)
    return "" unless text.present?

    # 1. Configure the HTML Renderer
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,     # Security: filters out user-injected HTML
      hard_wrap: true,       # Enter key creates a new line
      link_attributes: { rel: 'nofollow', target: "_blank" } # Open links in new tab
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
    
    # 3. Render
    markdown.render(text).html_safe
  end
end