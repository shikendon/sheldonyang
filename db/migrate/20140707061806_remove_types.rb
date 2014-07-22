class RemoveTypes < ActiveRecord::Migration
  def change
    drop_table :types
    remove_column :examples, :type_id
  end
end
