class AddStudentRefToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :student, foreign_key: true
  end
end
