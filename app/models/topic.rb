class Topic < ApplicationRecord
  attr_accessor  :name
  has_many :stories
  acts_as_list
#   def add_story(story)
#     self.stories << story
#     self.save
#   end
extend FriendlyId
friendly_id :name, use: :slugged


end
