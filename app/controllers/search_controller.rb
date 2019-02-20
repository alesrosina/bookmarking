# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @bookmarks = if params[:query].present?
                   Bookmark
                     .where('LOWER(title) like LOWER(:search) or
                                          LOWER(url) like LOWER(:search) or
                                          LOWER(shortening) like LOWER(:search) or id in
                                           (select bookmark_id from "bookmarks_tags" as bt, "tags" as t
                                             where t.id = bt.tag_id and LOWER(t.name) like LOWER(:search)
                                           )',
                            search: "%#{params[:query]}%")
                 else
                   []
                 end
  end
end
