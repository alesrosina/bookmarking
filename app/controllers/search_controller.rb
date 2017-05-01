class SearchController < ApplicationController

  def index
    if params[:query].present?
      @bookmarks = Bookmark
                     .where('LOWER(title) like LOWER(:search) or
                             LOWER(url) like LOWER(:search) or
                             LOWER(shortening) like LOWER(:search) or id in
(select bookmark_id from "bookmarks_tags" as bt, "tags" as t where t.id = bt.tag_id and LOWER(t.name) like LOWER(:search))',
                            search: "%#{params[:query]}%")
    else
      @bookmarks = []
    end
  end
end
