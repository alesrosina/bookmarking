class Tag < ApplicationRecord
  has_and_belongs_to_many :bookmarks

  scope :used, -> { Tag.joins(:bookmarks).group('tags.id').having('count(bookmarks.id) > 0') }
end
