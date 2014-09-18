class RemoveEmailFromToken < ActiveRecord::Migration
  def change
    change_table :tokens do |t|
      t.remove :email
    end
  end
end
