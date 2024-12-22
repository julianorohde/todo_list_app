# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[update destroy]

  def index
    @todos = current_user.todos.order(:status, :title)
    @editing_todo = Todo.find_by(id: params[:edit]) if params[:edit].present?
    @todos = @todos.where(status: params[:status]) if params[:status].present?
  end

  def create
    result = Todo::Create::UseCase.call(user: current_user, params: permitted_params)

    if result.successful?
      redirect_to todos_path
    else
      flash_error_and_redirect(result)
    end
  end

  def update
    result = Todo::Update::UseCase.call(user: current_user, params: permitted_params)

    if result.successful?
      redirect_to todos_path
    else
      flash_error_and_redirect(result)
    end
  end

  def destroy
    result = Todo::Destroy::UseCase.call(user: current_user, params: { id: params[:id] })
    
    if result.successful?
      handle_destroy_response
    else
      flash_error_and_redirect(result)
    end
  end

  private

  attr_accessor :todo

  def set_todo
    @todo = current_user.todos.find_by(id: params[:id])
  end
  
  def permitted_params
    params.require(:todo).permit(:title, :status).merge(id: params[:id])
  end

  def flash_error_and_redirect(result)
    flash[:alert] = result.attributes.messages[:base].join(', ')
    redirect_to todos_path
  end

  def handle_destroy_response
    respond_to do |format|
      format.turbo_stream
      format.html { head :no_content }
    end
  end
end
