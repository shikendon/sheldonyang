class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :example_id
      t.integer :tag_i18n_id
      t.timestamps
    end

    add_index :tags, :example_id
    add_index :tags, :tag_i18n_id
  end
end
