class AddPublishToRsses < ActiveRecord::Migration[5.0]
  def change
    add_column :rsses, :pub, :boolean, default: false
  end
end
