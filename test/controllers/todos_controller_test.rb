# frozen_string_literal: true

require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  context "TodosController Test" do
    setup do
      @user = create(:user)
      sign_in @user
    end

    context "#index method" do
      setup do
        @todos_pending = create_list(:todo, 5, status: 0, user: @user)
        @todos_complete = create_list(:todo, 5, status: 1, user: @user)
      end

      context "#all filter" do
        should "return all todos" do
          get todos_path
    
          assert_response :success
    
          assert_equal(@user.todos.order(:status, :title).to_a, assigns(:todos))
          assert_equal Todo.count, assigns(:todos).count
        end
      end

      context "#pending filter" do
        should "return only pending todos" do
          get todos_path(status: :pending)
    
          assert_response :success

          assert_equal(@user.todos.pending.order(:status, :title).to_a, assigns(:todos))
          assert_equal @todos_pending.count, assigns(:todos).count
        end
      end

      context "#completed filter" do
        should "return only pending todos" do
          get todos_path(status: :complete)
    
          assert_response :success

          assert_equal(@user.todos.complete.order(:status, :title).to_a, assigns(:todos))
          assert_equal @todos_complete.count, assigns(:todos).count
        end
      end
    end

    context "#create method" do
      should "call the Todo::Create::UseCase, and if it's successful, redirect to the index" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, true

        Todo::Create::UseCase.expects(:call).returns(result_mock)

        post todos_path, params: { todo: { title: 'Todo title' } }

        assert_redirected_to todos_path
      end

      should "call the Todo::Create::UseCase, and if it's unsuccessful, invoke the flash_error_and_redirect method" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, false
        result_mock.expect :attributes, OpenStruct.new(messages: { base: ["Title can't be blank"] })

        Todo::Create::UseCase.expects(:call).returns(result_mock)

        post todos_path, params: { todo: { title: '' } }

        assert_redirected_to todos_path
        assert_equal "Title can't be blank", flash[:alert]
      end
    end

    context "#update method" do
      setup do
        @todo = create(:todo, user: @user)
      end

      should "call the Todo::Update::UseCase, and if it's successful, redirect to the index" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, true

        Todo::Update::UseCase.expects(:call).returns(result_mock)

        patch todo_path(@todo), params: { todo: { title: 'Updated Title' } }

        assert_redirected_to todos_path
      end

      should "call the Todo::Update::UseCase, and if it's unsuccessful, invoke the flash_error_and_redirect method" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, false
        result_mock.expect :attributes, OpenStruct.new(messages: { base: ["Title can't be blank"] })

        Todo::Update::UseCase.expects(:call).returns(result_mock)

        patch todo_path(@todo), params: { todo: { title: '' } }

        assert_redirected_to todos_path
        assert_equal "Title can't be blank", flash[:alert]
      end
    end

    context "destroy method" do
      setup do
        @todo = create(:todo, user: @user)
      end

      should "call the Todo::Update::UseCase, and if it's successful invoke the handle_destroy_response method" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, true

        Todo::Destroy::UseCase.expects(:call).returns(result_mock)

        delete todo_path(@todo)

        assert_response :no_content
      end
    
      should "return not found for a non-existent todo" do
        result_mock = Minitest::Mock.new
        result_mock.expect :successful?, false
        result_mock.expect :attributes, OpenStruct.new(messages: { base: ['You are not authorized to delete this Todo!'] })

        Todo::Destroy::UseCase.expects(:call).returns(result_mock)

        delete todo_path(@todo)

        assert_redirected_to todos_path
        assert_equal 'You are not authorized to delete this Todo!', flash[:alert]
      end
    end
  end
end
