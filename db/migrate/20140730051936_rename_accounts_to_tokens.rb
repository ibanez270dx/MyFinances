class RenameAccountsToTokens < ActiveRecord::Migration
  def change
    rename_table :accounts, :tokens
  end
end
