class PagesController < ApplicationController
  def home
    # Fetch 3 most recent items for the "Preview" section
    @recent_posts = Post.where(published_at: ..Time.current).order(published_at: :desc).limit(3)
    @recent_projects = Project.order(published_at: :desc).limit(3)
  end

  def experiences
  end

  def about
  end
end
