class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :price, null: false
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.timestamps null: false
    end
  end
end
