class RemoveUpVoteFromNewsRsses < ActiveRecord::Migration[5.0]
  def change
    remove_column :news_rsses, :up_vote, :string
    remove_column :news_rsses, :down_vote, :string
  end
end
