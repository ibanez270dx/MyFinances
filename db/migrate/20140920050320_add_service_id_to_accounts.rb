class AddServiceIdToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :service_id
    end
  end
end
