# frozen_string_literal: true

require "test_helper"

class Todo::Update::UseCaseTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @todo = create(:todo, title: 'Old title', user: @user)
  end

  context "#call method" do
    should "return success when Todo is valid" do
      Todo::Update::Validation.any_instance.stubs(:valid?).returns(true)

      assert_changes '@todo.reload.title' do
        @result = Todo::Update::UseCase.call(user: @user, params: { id: @todo.id, title: 'New title' })
      end

      assert_instance_of ResultSuccess, @result
      assert_predicate(@result, :successful?)
    end

    should "return error when Todo is invalid" do
      Todo::Update::Validation.any_instance.stubs(:valid?).returns(false)

      assert_no_changes '@todo.status' do
        @result = Todo::Update::UseCase.call(user: @user, params: { id: @todo.id, status: 'complete' })
      end
      
      assert_instance_of ResultError, @result
      assert_not_predicate(@result, :successful?)
    end
  end
end
