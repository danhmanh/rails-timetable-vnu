class Course < ApplicationRecord
  validates :name, presence: true
  has_many :class_details
  belongs_to :student
end
