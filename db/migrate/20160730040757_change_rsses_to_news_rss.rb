class ChangeRssesToNewsRss < ActiveRecord::Migration[5.0]
  def change
    rename_table :rsses, :news_rsses
  end
end
