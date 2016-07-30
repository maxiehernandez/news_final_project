class AddPublishToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :pub, :boolean, default: false
  end
end
