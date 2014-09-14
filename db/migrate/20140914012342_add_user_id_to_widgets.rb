class AddUserIdToWidgets < ActiveRecord::Migration
  def change
    change_table :widgets do |t|
      t.integer :user_id
    end
  end
end
