class Campaign < ActiveRecord::Base
  belongs_to :user

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  
  validates :title, presence: true, uniqueness: {:scope => :description}
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than_or_equal_to: 10}

  delegate :full_name, :first_name, :last_name, to: :user, prefix: true  #prefix gives user_full_name

  #def full_name
  #  user.full_name
  #end

end
