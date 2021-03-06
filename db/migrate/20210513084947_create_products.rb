class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :image_id
      t.text :introduction
      t.boolean :is_sale, default: true
      t.integer :price

      t.string :product_name

      t.timestamps
    end
  end
end
