class AddNumberOfPartToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :number_of_part, :integer
  end
end
