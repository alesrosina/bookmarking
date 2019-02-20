# frozen_string_literal: true

class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :url
      t.string :title

      t.timestamps
    end
    add_index :sites, :url, unique: true
  end
end
