class RssFeed < ApplicationRecord
  validates :url, uniqueness: true
end
