# frozen_string_literal: true

require 'test_helper'

class Todo::Create::ValidationTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  context "#valid?" do
    should "return valid when the Todo is valid" do
      validation = Todo::Create::Validation.new(user: @user, params: { title: 'Todo title' })

      assert_predicate validation, :valid?
    end
  end

  context "#invalid?" do
    context "#validate_title validation" do
      should "return invalid when the title is blank" do
        validation = Todo::Create::Validation.new(user: @user, params: { title: '' })

        assert_predicate validation, :invalid?
        assert_equal 'Title cannot be blank!', validation.errors[:base].first
      end

      should "return invalid when the title is too long" do
        validation = Todo::Create::Validation.new(user: @user, params: { title: Faker::Lorem.characters(number: 41) })

        assert_predicate validation, :invalid?
        assert_equal 'Title is too long! Maximum is 40 characters.', validation.errors[:base].first
      end
    end

    context "#validate_status validation" do
      should "return invalid when trying to create a Todo with status 'complete'" do
        validation = Todo::Create::Validation.new(user: @user, params: { title: 'Todo title', status: 'complete' })

        assert_predicate validation, :invalid?
        assert_equal 'The status cannot be "completed" when creating a Todo!', validation.errors[:base].first
      end
    end
  end
end