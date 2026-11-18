module MarkdownHelper
  include ActionView::Helpers::SanitizeHelper

  def render_post_content(post)
    return "" unless post&.body.present?

    if post.is_html?
      sanitize(post.body, tags: markdown_allowed_tags, attributes: markdown_allowed_attributes)
    else
      markdown(post.body)
    end
  end

  def markdown(text)
    return "" unless text.present?

    renderer = Redcarpet::Render::HTML.new(
      filter_html: false,
      hard_wrap: true,
      link_attributes: { rel: "nofollow noopener noreferrer", target: "_blank" }
    )

    extensions = {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      superscript: true,
      highlight: true
    }

    markdown = Redcarpet::Markdown.new(renderer, extensions)

    sanitize(markdown.render(text), tags: markdown_allowed_tags, attributes: markdown_allowed_attributes)
  end

  private

  def markdown_allowed_tags
    %w[
      a abbr b blockquote br code del div em figcaption figure h1 h2 h3 h4 h5 h6
      hr i img li ol p pre s span strong sup sub table tbody td th thead tr u ul
    ]
  end

  def markdown_allowed_attributes
    %w[
      alt class href id rel src target title width height
    ]
  end
end