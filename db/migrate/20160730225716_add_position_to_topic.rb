class AddPositionToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :position, :integer
  end
end
