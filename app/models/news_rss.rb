class News_rss < ApplicationRecord
  validates :url, uniqueness: true
end
