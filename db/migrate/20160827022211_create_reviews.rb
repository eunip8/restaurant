class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :description, null: false
      t.integer :restaurant_id, null: false

      t.timestamps
    end
  end
end
