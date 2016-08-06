class AddPicToStory < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :pic, :text
  end
end
