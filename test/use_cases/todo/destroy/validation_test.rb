# frozen_string_literal: true

require 'test_helper'

class Todo::Destroy::ValidationTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @todo = create(:todo, user: @user)
  end

  context "#valid?" do
    should "return valid when the Todo is valid" do
      validation = Todo::Destroy::Validation.new(user: @user, todo: @todo)

      assert_predicate validation, :valid?
    end
  end

  context "#invalid?" do
    context "#validate_user_ownership validation" do
      setup do
        @unauthorized_user = create(:user)
      end

      should "return invalid when the user is not authorized to delete the Todo" do
        validation = Todo::Destroy::Validation.new(user: @unauthorized_user, todo: @todo)

        assert_predicate validation, :invalid?
        assert_equal 'You are not authorized to delete this Todo!', validation.errors[:base].first
      end
    end
  end
end
