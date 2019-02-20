# frozen_string_literal: true

class Site < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :url, uniqueness: true
end
