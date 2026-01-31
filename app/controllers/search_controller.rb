class SearchController < ApplicationController
  def index
    if params[:query].present?
      # This asks PgSearch to find matches across Posts AND Projects
      @results = PgSearch.multisearch(params[:query])
    else
      @results = []
    end
  end
end