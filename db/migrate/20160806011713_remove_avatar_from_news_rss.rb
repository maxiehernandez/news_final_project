class RemoveAvatarFromNewsRss < ActiveRecord::Migration[5.0]
  def change
    remove_column :news_rsses, :avatar, :string
  end
end
