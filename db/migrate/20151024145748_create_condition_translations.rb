class CreateConditionTranslations < ActiveRecord::Migration

  def change
    create_table :condition_translations do |t|
      t.integer :condition_id, :null => false
      t.string :locale, :null => false, :limit => 2
      t.string :name, :null => false
    end

    add_index :condition_translations, [:condition_id, :locale], :unique => true
  end

end
