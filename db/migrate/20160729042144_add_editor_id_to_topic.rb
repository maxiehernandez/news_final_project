class AddEditorIdToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :editor_id, :integer
  end
end
