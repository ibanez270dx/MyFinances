class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :bank
      t.string :access_token
      t.string :email
      t.timestamps
    end
  end
end
