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
      should "create a new todo and redirect to index" do
        todo_params = { title: 'New Todo' }

        assert_difference "Todo.count", 1 do
          post todos_path, params: { todo: todo_params }
        end

        assert_response :redirect
        assert_redirected_to todos_path
        assert_equal todo_params[:title], Todo.last.title
      end

      should "not create a todo with invalid params" do
        invalid_params = { title: "" }

        assert_no_difference "Todo.count" do
          post todos_path, params: { todo: invalid_params }
        end

        assert_response :redirect
        assert_redirected_to todos_path
        assert_equal "Title can't be blank", flash[:alert]
      end
    end

    context "#update method" do
      setup do
        @todo = create(:todo, user: @user)
      end

      should "update a todo and redirect to index" do
        new_params = { title: 'Updated Title' }

        assert_changes '@todo.reload.title' do
          patch todo_path(@todo), params: { todo: new_params }
        end

        assert_response :redirect
        assert_redirected_to todos_path

        assert_equal new_params[:title], @todo.reload.title
      end

      should "not update a todo with invalid params" do
        invalid_params = { title: '' }

        assert_no_changes '@todo.title' do
          patch todo_path(@todo), params: { todo: invalid_params }
        end

        assert_response :redirect
        assert_redirected_to todos_path
        assert_equal "Title can't be blank", flash[:alert]
      end
    end

    context "destroy method" do
      setup do
        @todo = create(:todo, user: @user)
      end

      should "destroy a todo and respond correctly" do
        assert_difference "Todo.count", -1 do
          delete todo_path(@todo)
        end
    
        assert_response :no_content
      end
    
      should "return not found for a non-existent todo" do
        @todo.destroy

        assert_no_difference "Todo.count" do
          delete todo_path(@todo)
        end
    
        assert_response :not_found
      end
    end
  end
end
