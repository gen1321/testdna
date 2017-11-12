class AddSocProfile < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :soc_profile, :string)
  end
end
