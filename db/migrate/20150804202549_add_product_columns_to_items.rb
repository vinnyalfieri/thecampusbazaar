class AddProductColumnsToItems < ActiveRecord::Migration
  def change
    add_attachment :items, :product
  end
end
