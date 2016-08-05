class RemovePubFromNewsRsses < ActiveRecord::Migration[5.0]
  def change
    remove_column :news_rsses, :pub, :boolean
  end
end
