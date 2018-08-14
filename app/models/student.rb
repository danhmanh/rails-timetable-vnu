class Student < ApplicationRecord
  validates :id, presence: true, length: {is: 8}, uniqueness: true
  validates :name, presence: true

  has_many :courses
  has_many :class_details
end
