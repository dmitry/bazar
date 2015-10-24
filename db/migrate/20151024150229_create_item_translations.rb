class CreateItemTranslations < ActiveRecord::Migration

  def change
    create_table :item_translations do |t|
      t.integer :item_id, :null => false
      t.string :locale, :null => false, :limit => 2
      t.string :name, :null => false
      t.text :description, :null => false
    end

    add_index :item_translations, [:item_id, :locale], :unique => true
  end

end
