class ProjectsController < ApplicationController
  def index
    # Search Logic (Phase 2 Requirement)
    if params[:query].present?
      @projects = Project.multisearch(params[:query]).map(&:searchable)
    else
      @projects = Project.where(published_at: ..Time.current).order(published_at: :desc)
    end
  end

  def show
    @project = Project.find_by!(slug: params[:id])
  end
end