module MarkdownHelper
  def markdown(text)
    return "" unless text.present?

    # 1. Configure the HTML Renderer
    renderer = Redcarpet::Render::HTML.new(
      filter_html: false,     # <--- CHANGE THIS to false so your <div> tags work!
      hard_wrap: true, 
      link_attributes: { rel: 'nofollow', target: "_blank" }
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