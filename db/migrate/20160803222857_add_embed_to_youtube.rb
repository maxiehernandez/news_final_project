class AddEmbedToYoutube < ActiveRecord::Migration[5.0]
  def change
    add_column :youtubes, :embed, :string
  end
end
