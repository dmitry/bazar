class AddSourceCdToItemTranslations < ActiveRecord::Migration
  def change
    add_column :item_translations, :source_cd, :integer, null: false, default: 0
  end
end
