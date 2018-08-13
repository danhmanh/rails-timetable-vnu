class User < ApplicationRecord
  validates :name, presence: true
  validates :student_id, presence: true
end
