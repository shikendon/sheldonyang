class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :example_id
      t.string :matchtext
      t.string :aliastext
      t.string :transtext
      t.timestamps
    end

    add_index :comments, :example_id
  end
end
