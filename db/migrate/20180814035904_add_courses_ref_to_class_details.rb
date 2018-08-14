class AddCoursesRefToClassDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :class_details, :course, foreign_key: true
  end
end
