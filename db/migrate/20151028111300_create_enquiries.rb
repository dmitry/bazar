class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.integer :item_id, null: false
      t.string :name
      t.string :email, null: false
      t.string :phone
      t.text :message

      t.timestamps null: false
    end
  end
end
