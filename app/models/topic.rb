class Topic < ApplicationRecord
  has_many :stories
  acts_as_list
#   def add_story(story)
#     self.stories << story
#     self.save
#   end
end
