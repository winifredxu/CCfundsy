class Categorization < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :category
end
