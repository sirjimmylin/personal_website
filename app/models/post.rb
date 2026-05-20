class Post < ApplicationRecord
  include PgSearch::Model

  # This creates a "global" search scope
  multisearchable against: [ :title, :summary, :body ]

  scope :published, -> { where(published_at: ..Time.current) }

  # Friendly URLs (e.g., /posts/my-data-science-project)
  def to_param
  slug.presence || id.to_s
  end

  def published?
    published_at.present? && published_at <= Time.current
  end
end
