module Admin
  class PostsController < AdminController
    before_action :set_post, only: [:edit, :update, :destroy]

    def index
      @posts = Post.order(created_at: :desc)
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to admin_posts_path, notice: "Draft created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find_by!(slug: params[:slug])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :summary, :body, :published_at, :tag_list)
    end
  end
end