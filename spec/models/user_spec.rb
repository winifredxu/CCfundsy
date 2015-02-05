require 'rails_helper'

RSpec.describe User, type: :model do

  def user_attrs(new_attr = {})
    valid_attr = {first_name: "john", 
                  last_name: "smith", 
                  email: "johnsmith@codecore.ca", 
                  password: "123"}
    valid_attr.merge(new_attr)
  end


  describe "Validations" do
    
    it "requires an email" do
      user1 = User.new(user_attrs({email: nil}))
      expect(user1).to be_invalid
    end

    it "requires a unique email" do
      user1 = User.create(user_attrs({email: "abc@codecore.ca"}))
      user2 = User.new(user_attrs({email: "abc@codecore.ca"}))
      expect(user2).to be_invalid
    end

    it "requires an email with a valid format" do
      user3 = User.new(user_attrs({email: "bad_email_format"}))
      expect(user3).to be_invalid
    end

  end


  describe ".full_name" do

    it "returns concatenated first and last names if given" do
      user = User.new(user_attrs)
      added_name = "#{user_attrs[:first_name]} #{user_attrs[:last_name]}"
      expect(user.full_name).to eq(added_name)
    end

    it "returns email if first and last names are not given" do
      user = User.new(user_attrs({first_name: nil, last_name: nil}))
      expect(user.full_name).to eq(user_attrs[:email])
    end

  end

  describe "Hashing the password" do

    it "generates password digest when given password" do
      test_user = User.new(user_attrs)
      test_user.save
      expect(test_user.password_digest).to be
    end

  end

end
