class RecreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :plaid_id
      t.string :institution
      t.string :name
      t.string :kind
    end
  end
end
