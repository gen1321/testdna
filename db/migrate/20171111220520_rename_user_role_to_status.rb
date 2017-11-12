class RenameUserRoleToStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column(:users, :role, :integer)
    add_column(:users, :status, :integer)
  end
end
