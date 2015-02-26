class RewardLevel < ActiveRecord::Base
  belongs_to :campaign #this is example used for NESTED attributes
  has_many :pledges, dependent: :nullify
  
  validates :title, :amount, uniqueness: {scope: :campaign_id}
  validates :title, :body, :amount, :quantity, presence: true
  
end