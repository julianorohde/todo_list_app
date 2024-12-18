# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "#valid?" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
  end

  context "devise modules" do    
    should "includes Devise modules" do
      assert_includes User.devise_modules, :database_authenticatable
      assert_includes User.devise_modules, :registerable
      assert_includes User.devise_modules, :recoverable
      assert_includes User.devise_modules, :rememberable
      assert_includes User.devise_modules, :validatable
    end
  end

  context "password validations" do
    should "requires password for a new user" do
      user = build(:user, password: nil)

      assert_not user.valid?
      assert_includes user.errors[:password], "can't be blank"
    end
  end

  context "email validations" do
    should "requires a valid email format" do
      user = build(:user, email: 'invalid_email')

      assert_not user.valid?
      assert_includes user.errors[:email], "is invalid"
    end
  end
end
