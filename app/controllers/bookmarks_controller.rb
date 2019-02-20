# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    @sites = Site.all
  end

  def create
    @bookmark = Bookmark.create permitted_params
    if @bookmark.valid?
      flash[:notice] = 'Bookmark was successfully created.'
      redirect_to bookmarks_path
    else
      flash[:error] = 'There were errors. Please fix them below.'
      render 'new'
    end
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find params[:id]
  end

  def update
    @bookmark = Bookmark.find params[:id]
    if @bookmark.update permitted_params
      flash[:notice] = 'Bookmark was successfully updated.'
      redirect_to bookmarks_path
    else
      flash[:error] = 'There were errors. Please fix them below.'
      render 'edit'
    end
  end

  def destroy
    bookmark = Bookmark.find params[:id]
    bookmark.destroy

    flash[:notice] = 'Bookmark was successfully deleted.'
    redirect_to bookmarks_path
  end

  private

  def permitted_params
    params.require(:bookmark).permit(:id, :title, :url, :shortening, :all_tags)
  end
end
