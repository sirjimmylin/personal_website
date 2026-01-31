class PostsController < ApplicationController
  # 1. CRITICAL: This line finds the post before 'show', 'edit', 'update', or 'destroy' runs.
  # If this is missing, @post will be nil, causing your error.
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts
  def index
    if params[:query].present?
      # Search logic
      @results = PgSearch.multisearch(params[:query])
      @posts = @results.map(&:searchable).select { |r| r.is_a?(Post) }
      
    elsif params[:tag].present?
      # --- NEW: Filter by Tag ---
      @posts = Post.where(tag: params[:tag])
      
    else
      # Default: Show all (Ordered by newest first)
      @posts = Post.all.order(created_at: :desc)
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
      # 1. First, try to find by the standard ID number (e.g., /posts/1)
      @post = Post.find_by(id: params[:id])

      # 2. If we didn't find it by ID, assume the URL is a Title (e.g., /posts/my-first-test)
      if @post.nil?
        # Convert "my-first-test" back to "my first test" to search the database
        possible_title = params[:id].gsub("-", " ")
        
        # Search for the title (ignoring upper/lower case)
        @post = Post.where("LOWER(title) = ?", possible_title.downcase).first
      end

      # 3. If we STILL can't find it, safe redirect
      if @post.nil?
        redirect_to posts_path, alert: "Could not find that post."
      end
    end
  end