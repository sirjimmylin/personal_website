class SearchController < ApplicationController
  def index
    if params[:query].present?
      # This asks PgSearch to find matches across Posts AND Projects
      @results = PgSearch.multisearch(params[:query])
      @results = @results.select do |result|
        searchable = result.searchable
        authenticated? || !searchable.respond_to?(:published?) || searchable.published?
      end
    else
      @results = []
    end
  end
end
