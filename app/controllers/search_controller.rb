class SearchController < ApplicationController

  def index
    if params[:query].present?
      @bookmarks = Bookmark.where('LOWER(title) like LOWER(:search) or LOWER(url) like LOWER(:search) or LOWER(shortening) like LOWER(:search)', search: "%#{params[:query]}%")
    else
      @bookmarks = []
    end
  end
end
