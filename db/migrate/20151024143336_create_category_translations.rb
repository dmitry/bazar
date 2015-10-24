class CreateCategoryTranslations < ActiveRecord::Migration

  def change
    create_table :category_translations do |t|
      t.integer :category_id, :null => false
      t.string :locale, :null => false, :limit => 2
      t.string :name, :null => false
    end

    add_index :category_translations, [:category_id, :locale], :unique => true
  end

end
