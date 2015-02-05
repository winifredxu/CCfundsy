class Campaign < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {:scope => :description}
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than_or_equal_to: 10}
end
