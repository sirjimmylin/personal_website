class PostsController < ApplicationController
  # 1. CRITICAL: This line finds the post before 'show', 'edit', 'update', or 'destroy' runs.
  # If this is missing, @post will be nil, causing your error.
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :ensure_post_is_published, only: :show

  # GET /posts
  def index
    scope = authenticated? ? Post.all : Post.published

    if params[:query].present?
      # Search logic
      @results = PgSearch.multisearch(params[:query])
      @posts = @results.map(&:searchable).select { |r| r.is_a?(Post) }
      @posts = @posts.select(&:published?) unless authenticated?

    elsif params[:tag].present?
      # --- NEW: Filter by Tag ---
      @posts = scope.where(tag: params[:tag])

    else
      # Only show posts where published_at is in the PAST or PRESENT
      @posts = scope.order(created_at: :desc)
    end
  end

  # GET /posts/1
  def show
    # @post is found automatically by the before_action above
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully destroyed."
  end

  private

  # Find the post by ID *or* by Title
  def set_post
    @post = Post.find_by(slug: params[:id]) || Post.find_by(id: params[:id])

    if @post.nil?
      redirect_to posts_path, alert: "Could not find that post."
      nil
    end
  end

  def ensure_post_is_published
    return if authenticated?
    return if @post.published?

    redirect_to posts_path, alert: "That post is not live yet."
  end
end
