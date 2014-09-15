class AddServiceToAccount < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :service
    end
  end
end
