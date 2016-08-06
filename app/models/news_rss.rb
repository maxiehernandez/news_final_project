class News_rss < ApplicationRecord
  validates :url, uniqueness: true
  has_attached_file :avatar,
                    :styles => {
                      :thumb => "90x90>",
                      :small => "150x150>",
                    }
end
