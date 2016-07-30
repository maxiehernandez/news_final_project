class RenameTweetsToSocMed < ActiveRecord::Migration[5.0]
  def change
    rename_table :tweets, :soc_med
  end
end
