class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|

      t.timestamps null: false
    end
  end
end
