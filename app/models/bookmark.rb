# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :site
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :url, presence: true

  before_validation :set_parent_site
  around_destroy :destroy_orphaned_parent

  scope :tagged_with, ->(tag_name) { joins(:tags).where('tags.name=?', tag_name) }

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  private

  def set_parent_site
    url_base = URI.parse(url).host
    if url_base.present?
      url_base = "http://#{url_base}" unless url_base.start_with? 'http'
      self.site = Site.find_or_create_by(url: url_base)
    end
  end

  def destroy_orphaned_parent
    parent = site
    yield # executes a DELETE database statement
    parent.destroy if parent.bookmarks.empty?
  end
end
