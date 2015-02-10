class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: {:scope => :description}
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than_or_equal_to: 10}

end
