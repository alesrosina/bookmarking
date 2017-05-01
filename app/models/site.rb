class Site < ApplicationRecord
  has_many :bookmarks

  validates :url, uniqueness: true
end
