class AddIndexToTopics < ActiveRecord::Migration[5.0]
  def change
    add_index :topics, :slug, unique: true
  end
end
