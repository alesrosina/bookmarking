class BookmarksController < ApplicationController

  def index
    @sites = Site.all
  end

  def create
    Bookmark.create! permitted_params

    flash[:notice] = 'Bookmark was successfully created.'
    redirect_to bookmarks_path
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find params[:id]
  end

  def update
    Bookmark.update permitted_params

    flash[:notice] = 'Bookmark was successfully updated.'
    redirect_to bookmarks_path
  end

  def destroy
    bookmark = Bookmark.find params[:id]
    bookmark.destroy

    flash[:notice] = 'Bookmark was successfully deleted.'
    redirect_to bookmarks_path
  end

  private

  def permitted_params
    params.require(:bookmark).permit(:id, :title, :url, :shortening)
  end
end
