class CreateClassDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :class_details do |t|
      t.string :name
      t.integer :class_time
      t.integer :day_of_week
      t.string :place
      t.timestamps
    end
  end
end
