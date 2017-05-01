class SearchController < ApplicationController

  def index
    if params[:query].present?
      @bookmarks = Bookmark.where('title like :search or url like :search or shortening like :search', search: "%#{params[:query]}%")
    else
      @bookmarks = []
    end
  end
end
