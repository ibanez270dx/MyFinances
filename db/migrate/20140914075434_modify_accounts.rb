class ModifyAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.remove :institution
      t.integer :token_id
      t.string :nickname
    end
  end
end
