class RewardLevel < ActiveRecord::Base
  belongs_to :campaign #this is example used for NESTED attributes

  validates :title, :body, :amount, :quantity, presence: true
  validates :title, :amount, uniqueness: {scope: :campaign_id}
end
