module Admin
  class PostsController < AdminController
    # This line says: "Run set_post before edit, update, and destroy"
    before_action :set_post, only: [:edit, :update, :destroy]

    def index
      # Start with all posts
      @posts = Post.all.order(created_at: :desc)

      # Filter by Tag (if clicked)
      if params[:tag].present?
        @posts = @posts.where(tag: params[:tag])
      end

      # Filter by Status (if clicked)
      if params[:status] == 'published'
        @posts = @posts.where("published_at <= ?", Time.current)
      elsif params[:status] == 'draft'
        @posts = @posts.where("published_at IS NULL OR published_at > ?", Time.current)
      end
    end

    def new
      @post = Post.new
    end

    def create
    @post = Post.new(post_params)

    # Check which button was clicked
    if params[:commit_action] == "publish"
      @post.published_at = Time.current
    else
      @post.published_at = nil # It's a draft
    end

    if @post.save
      redirect_to admin_posts_path, notice: "Post was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

    def edit
    end

    def update
    # Update standard fields first
    @post.assign_attributes(post_params)

    # Check button action
    if params[:commit_action] == "publish"
      @post.published_at = Time.current
    elsif params[:commit_action] == "draft"
      @post.published_at = nil
    end

    if @post.save
      redirect_to admin_posts_path, notice: "Post was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

    # --- MAKE SURE THIS METHOD EXISTS AND IS ABOVE 'PRIVATE' ---
  def destroy
    @post = Post.find_by!(slug: params[:slug])
    @post.destroy
    redirect_to admin_posts_path, notice: "Post was successfully deleted."
  end
    # -----------------------------------------------------------

    private  # <--- Everything below this line is hidden

    def set_post
      # 1. Try to find by Slug first (e.g. "my-math-post")
      @post = Post.find_by(slug: params[:slug])
      
      # 2. If not found, try finding by ID (e.g. "4")
      # (This handles the specific error you are seeing now)
      @post ||= Post.find_by(id: params[:slug])

      # 3. If still nothing, redirect safely
      if @post.nil?
        redirect_to admin_posts_path, alert: "Post not found."
      end
    end

    def post_params
      params.require(:post).permit(:title, :slug, :summary, :body, :published_at, :tag_list, :tag)
    end
  end
end