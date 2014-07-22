class CreateTagI18ns < ActiveRecord::Migration
  def change
    create_table :tag_i18ns do |t|
      t.string :name
      t.timestamps
    end
  end
end
