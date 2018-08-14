class AddDurationToClassDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :class_details, :duration, :integer
  end
end
