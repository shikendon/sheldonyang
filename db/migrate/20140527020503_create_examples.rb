class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.integer :user_id
      t.text :text
      t.boolean :verified, null: false, default: false
      t.timestamps
    end

    add_index :examples, :user_id
  end
end
