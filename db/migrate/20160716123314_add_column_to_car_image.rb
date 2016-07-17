class AddColumnToCarImage < ActiveRecord::Migration
  def change
    add_column :car_images, :temp_file_path, :string
  end
end
