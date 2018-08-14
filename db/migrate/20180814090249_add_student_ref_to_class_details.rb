class AddStudentRefToClassDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :class_details, :student, foreign_key: true
  end
end
