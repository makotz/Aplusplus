class AddFacebookOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :facebook_token, :string
    add_column :users, :facebook_secret, :string
    add_column :users, :facebook_raw_data, :text
    add_column :users, :profile_image, :string

    add_index :users, [:uid, :provider]
  end
end
