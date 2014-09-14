class AddTypeToWidget < ActiveRecord::Migration
  def change
    change_table :widgets do |t|
      t.string :type
    end
  end
end
