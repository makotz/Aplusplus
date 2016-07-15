class RemoveFacebookSecretColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_secret, :string
    add_column :users, :facebook_expires_at, :integer
  end
end
