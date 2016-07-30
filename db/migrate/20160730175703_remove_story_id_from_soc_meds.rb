class RemoveStoryIdFromSocMeds < ActiveRecord::Migration[5.0]
  def change
    remove_column :soc_meds, :story_id, :integer
  end
end
