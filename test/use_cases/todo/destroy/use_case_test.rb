# frozen_string_literal: true

require "test_helper"

class Todo::Destroy::UseCaseTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @todo = create(:todo, user: @user)
  end

  context "#call method" do
    should "return success when Todo is valid" do
      Todo::Destroy::Validation.any_instance.stubs(:valid?).returns(true)
      
      assert_difference "Todo.count", -1 do
        @result = Todo::Destroy::UseCase.call(user: @user, params: { id: @todo.id })
      end

      assert_instance_of ResultSuccess, @result
      assert_predicate(@result, :successful?)
    end

    should "return error when Todo is invalid" do
      Todo::Destroy::Validation.any_instance.stubs(:valid?).returns(false)

      assert_no_difference "Todo.count" do
        @result = Todo::Destroy::UseCase.call(user: @user, params: { id: @todo.id })
      end
      
      assert_instance_of ResultError, @result
      assert_not_predicate(@result, :successful?)
    end
  end
end
