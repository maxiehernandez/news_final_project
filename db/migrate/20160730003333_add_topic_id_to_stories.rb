class AddTopicIdToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :topic_id, :int
  end
end
