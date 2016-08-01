class AddStoryTypeToStory < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :story_type, :string
  end
end
