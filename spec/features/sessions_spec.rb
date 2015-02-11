require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "Signing in" do
    let(:user) { create(:user) }

    it "redirects the user to the homepage" do
      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign Up"
      expect(current_path).to eq(root_path)
    end

  end
end
