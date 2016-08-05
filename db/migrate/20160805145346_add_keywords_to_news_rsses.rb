class AddKeywordsToNewsRsses < ActiveRecord::Migration[5.0]
  def change
    add_column :news_rsses, :summary, :text, :null => true
    add_column :news_rsses, :keywords, :text, :null =>true
  end
end
