class AddUserReferencsToCampaigns < ActiveRecord::Migration
  def change
    add_reference :campaigns, :user, index: true
    add_foreign_key :campaigns, :users
  end
end
