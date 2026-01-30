class Post < ApplicationRecord
  include PgSearch::Model
  
  # This creates a "global" search scope
  multisearchable against: [:title, :summary, :body]

  # Friendly URLs (e.g., /posts/my-data-science-project)
  def to_param
    slug
  end
end