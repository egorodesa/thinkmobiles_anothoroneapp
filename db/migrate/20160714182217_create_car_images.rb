class CreateCarImages < ActiveRecord::Migration
  def change
    create_table :car_images do |t|
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
