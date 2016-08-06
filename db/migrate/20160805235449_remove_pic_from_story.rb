class RemovePicFromStory < ActiveRecord::Migration[5.0]
  def change
    remove_column :stories, :pic, :text
  end
end
