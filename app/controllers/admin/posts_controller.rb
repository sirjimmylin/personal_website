module Admin
  class PostsController < AdminController
    # This line says: "Run set_post before edit, update, and destroy"
    before_action :set_post, only: [:edit, :update, :destroy]

    def index
      if params[:tag].present?
      # Filter by tag if provided
        @posts = Post.where(tag: params[:tag]).order(created_at: :desc)
      else
       # Otherwise show all
        @posts = Post.all.order(created_at: :desc)
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
      @post = Post.find_by!(slug: params[:slug])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :summary, :body, :published_at, :tag_list, :tag)
    end
  end
end