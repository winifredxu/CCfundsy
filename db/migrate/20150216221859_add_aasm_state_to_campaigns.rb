class AddAasmStateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :aasm_state, :string
    add_index :campaigns, :aasm_state  #add index to make DB search faster
  end
end
