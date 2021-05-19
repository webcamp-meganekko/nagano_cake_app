class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :customer_id
      t.integer :product_id

      t.timestamps
    end
  end
end
