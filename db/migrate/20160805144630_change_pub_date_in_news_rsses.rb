class ChangePubDateInNewsRsses < ActiveRecord::Migration[5.0]
  def change
    change_column :news_rsses, :pub_date, :date
  end
end
