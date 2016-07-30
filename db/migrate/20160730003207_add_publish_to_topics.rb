class AddPublishToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :pub_home, :boolean, default: false
  end
end
