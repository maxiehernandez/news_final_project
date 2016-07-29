class ChangeNameToUName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :u_name
  end
end
