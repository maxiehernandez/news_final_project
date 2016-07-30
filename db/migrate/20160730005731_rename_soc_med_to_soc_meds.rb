class RenameSocMedToSocMeds < ActiveRecord::Migration[5.0]
  def change
    rename_table :soc_med, :soc_meds
  end
end
