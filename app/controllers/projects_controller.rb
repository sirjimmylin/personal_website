class ProjectsController < ApplicationController
  def index
    if params[:query].present?
      # 1. Run the search
      # 2. Convert results back to Project objects
      # 3. FILTER: Only keep projects that are actually published
      @projects = Project.multisearch(params[:query])
                         .map(&:searchable)
                         .select { |project| project.published_at.present? && project.published_at <= Time.current }
    else
      # Default: Show all published projects (Range syntax '..' handles <= automatically)
      @projects = Project.where(published_at: ..Time.current).order(published_at: :desc)
    end
  end

  def show
    # Finds the project by Slug
    @project = Project.find_by!(slug: params[:id])
    
    # SECURITY CHECK:
    # If a user guesses the URL of a draft project, kick them out.
    # (Unless you want them to see a 404, which is also fine)
    if @project.published_at.nil? || @project.published_at > Time.current
      redirect_to projects_path, alert: "That project is not live yet."
    end
  end
end