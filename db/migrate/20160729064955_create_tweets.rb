class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :tweeters_id
      t.string :tweet_id
      t.integer :favorites
      t.integer :retweets
      t.integer :story_id
      t.string :text
      t.string :hashtags
      t.string :mentions
      t.text :urls
      t.integer :followers
      t.string :screen_name
      t.integer :friends
      t.integer :rank

      t.timestamps
    end
  end
end
