class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
