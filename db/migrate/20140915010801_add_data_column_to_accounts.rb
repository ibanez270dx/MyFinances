class AddDataColumnToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.remove :plaid_id
      t.remove :name
      t.remove :kind
      t.rename :nickname, :name
      t.text :data
    end
  end
end
