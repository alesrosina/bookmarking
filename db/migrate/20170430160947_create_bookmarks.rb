class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :shortening
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
