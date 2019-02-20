# frozen_string_literal: true

class CreateJoinTableBookmarkTag < ActiveRecord::Migration[5.0]
  def change
    create_join_table :bookmarks, :tags do |t|
      t.index %i[bookmark_id tag_id]
      t.index %i[tag_id bookmark_id]

      t.timestamps
    end
  end
end
