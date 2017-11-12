class AddBannedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :banned_at, :datetime)
  end
end
