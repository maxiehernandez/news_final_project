class ChangeTweetIdInSocMeds < ActiveRecord::Migration[5.0]
  def change
    rename_column :soc_meds, :tweet_id, :t_id
  end
end
