class AddAvatarColumnsToNewsRsses < ActiveRecord::Migration[5.0]
  def up
   add_attachment :news_rsses, :avatar
 end

 def down
   remove_attachment :news_rsses, :avatar
 end
end
