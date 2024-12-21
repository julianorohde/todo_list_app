# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[edit update destroy]

  def index
    @todos = current_user.todos.order(:status, :title)
    @editing_todo = Todo.find_by(id: params[:edit]) if params[:edit].present?
    @todos = @todos.where(status: params[:status]) if params[:status].present?
  end

  def create
    todo = current_user.todos.create(permitted_params)
    
    if todo.save
      redirect_to todos_path
    else
      flash_error_and_redirect(todo)
    end
  end

  def update
    if todo.update(permitted_params)
      redirect_to todos_path
    else
      flash_error_and_redirect(todo)
    end
  end

  def destroy
    if todo
      todo.destroy

      handle_destroy_response
    else
      head :not_found
    end
  end

  private

  attr_accessor :todo

  def set_todo
    @todo = current_user.todos.find_by(id: params[:id])
  end
  
  def permitted_params
    params.require(:todo).permit(:title, :status)
  end

  def flash_error_and_redirect(todo)
    flash[:alert] = todo.errors.full_messages.to_sentence
    redirect_to todos_path
  end

  def handle_destroy_response
    respond_to do |format|
      format.turbo_stream
      format.html { head :no_content }
    end
  end
end
