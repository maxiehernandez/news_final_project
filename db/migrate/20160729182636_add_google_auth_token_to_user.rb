class AddGoogleAuthTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_auth_token, :string
  end
end
