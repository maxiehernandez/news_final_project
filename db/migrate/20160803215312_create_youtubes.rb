class CreateYoutubes < ActiveRecord::Migration[5.0]
  def change
    create_table :youtubes do |t|
      t.string :youtube_id
      t.timestamps
    end
  end
end
