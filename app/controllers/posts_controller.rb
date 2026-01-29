class PostsController < ApplicationController
  def index
    # Search Logic (Phase 2 Requirement)
    if params[:query].present?
      @posts = Post.multisearch(params[:query]).map(&:searchable)
    else
      @posts = Post.where(published_at: ..Time.current).order(published_at: :desc)
    end
  end

  def show
    @post = Post.find_by!(slug: params[:id])
  end
end