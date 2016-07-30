class Topic < ApplicationRecord
  has_many :stories

  def add_story(story)
    self.stories << story
    self.save
  end
end
