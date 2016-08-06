class RemoveAvatarFromNewRsses < ActiveRecord::Migration[5.0]
  def change
    remove_column :news_rsses, :avatar_file_name
    remove_column :news_rsses, :avatar_content_type
    remove_column :news_rsses, :avatar_file_size
    remove_column :news_rsses, :avatar_updated_at
  end
end
