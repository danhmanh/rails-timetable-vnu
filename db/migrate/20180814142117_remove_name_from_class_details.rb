class RemoveNameFromClassDetails < ActiveRecord::Migration[5.2]
  def change
  remove_column :class_details, :name
  end
end
