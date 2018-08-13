class AddNameAndStudentIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :student_id, :integer
    add_column :users, :name, :string
  end
end
