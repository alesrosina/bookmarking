class Bookmark < ApplicationRecord
  belongs_to :site

  validates :title, :presence => true
  validates :url, :presence => true

  before_validation :set_parent_site
  around_destroy :destroy_orphaned_parent

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
