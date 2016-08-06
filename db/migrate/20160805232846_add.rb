class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :news_rsses, :pic_url, :text
  end
end
