# frozen_string_literal: true

class Todo::Destroy::UseCase
  def self.call(user: nil, params: nil)
    new(user: user, params: params).call
  end

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    todo = Todo.find_by(id: params[:id])

    validation = Todo::Destroy::Validation.new(user: user, todo: todo)

    if validation.valid?
      todo.destroy

      ResultSuccess.new
    else
      ResultError.new(validation.errors)
    end
  end

  private

  attr_reader :user, :params
end
