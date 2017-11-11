class AddGenericFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :city
      t.string :document
    end
  end
end
