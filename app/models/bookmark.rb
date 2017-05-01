class Bookmark < ApplicationRecord
  belongs_to :site
  has_and_belongs_to_many :tags

  validates :title, :presence => true
  validates :url, :presence => true

  before_validation :set_parent_site
  around_destroy :destroy_orphaned_parent

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  private

  def set_parent_site
    url_base = URI.parse(self.url).host
    if url_base.present?
      url_base = "http://#{url_base}" unless url_base.start_with? 'http'
      self.site = Site.find_or_create_by(url: url_base)
    end
  end

  def destroy_orphaned_parent
    parent = self.site
    yield # executes a DELETE database statement
    if parent.bookmarks.length == 0
      parent.destroy
    end
  end
end
