class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :seller_id
      t.float :price
      t.text :description
      t.string :condition
      t.timestamps null: false
    end
  end
end
