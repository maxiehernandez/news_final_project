class RemoveFollowersFromSocMed < ActiveRecord::Migration[5.0]
  def change
    remove_column :soc_meds, :followers, :integer
    remove_column :soc_meds, :screen_name, :string
    remove_column :soc_meds, :friends, :integer
    remove_column :soc_meds, :rank, :integer
  end
end
