class AddCourseStridToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :strid, :string
  end
end
