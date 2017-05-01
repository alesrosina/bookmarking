class SearchController < ApplicationController

  def index
    @bookmarks = Bookmark.where('title like :search or url like :search or shortening like :search', search: "%#{params[:query]}%")
  end
end
