class CreateRsses < ActiveRecord::Migration[5.0]
  def change
    create_table :rsses do |t|
      t.string :source_id
      t.string :source_name
      t.string :pub_date
      t.string :story_id
      t.string :headline
      t.text :url
      t.string :up_vote
      t.string :down_vote

      t.timestamps
    end
  end
end
