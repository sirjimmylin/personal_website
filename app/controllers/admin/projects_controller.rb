module Admin
  class ProjectsController < AdminController
    before_action :set_project, only: [:edit, :update, :destroy]

    def index
      @projects = Project.order(published_at: :desc)
    end

    def new
      @project = Project.new
    end

    def create
    @project = Project.new(project_params)

    if params[:commit_action] == "publish"
      @project.published_at = Time.current
    else
      @project.published_at = nil
    end

    if @project.save
      redirect_to admin_projects_path, notice: "Project was successfully saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

    def edit
    end

    def update
    @project.assign_attributes(project_params)

    if params[:commit_action] == "publish"
      @project.published_at = Time.current
    elsif params[:commit_action] == "draft"
      @project.published_at = nil
    end

    if @project.save
      redirect_to admin_projects_path, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

 def destroy
    # CHANGE THIS LINE: Use find_by!(slug: params[:slug])
    @project = Project.find_by!(slug: params[:slug])
    
    @project.destroy
    redirect_to admin_projects_path, notice: "Project was successfully deleted."
  end
    private

    def set_project
      @project = Project.find_by!(slug: params[:slug])
    end

    def project_params
      # Note: We added repo_link and demo_link here
      params.require(:project).permit(:title, :slug, :summary, :body, :published_at, :repo_link, :demo_link)
    end
  end
end