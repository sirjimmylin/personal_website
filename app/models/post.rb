class Post < ApplicationRecord
  include PgSearch::Model

  # Index stripped plain text so Substack HTML tags don't pollute search results
  multisearchable against: [ :title, :summary, :plain_text_body ]

  scope :published, -> { where(published_at: ..Time.current) }

  # Friendly URLs (e.g., /posts/my-data-science-project)
  def to_param
    slug.presence || id.to_s
  end

  def published?
    published_at.present? && published_at <= Time.current
  end

  def plain_text_body
    ActionView::Base.full_sanitizer.sanitize(body).to_s.squish
  end
end
