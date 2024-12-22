# frozen_string_literal: true

class Todo::Update::UseCase
  def self.call(user: nil, params: nil)
    new(user: user, params: params).call
  end

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    todo = Todo.find_by(id: params[:id])

    validation = Todo::Update::Validation.new(user: user, params: params)

    if validation.valid?
      todo.update(params.merge(user: user))

      ResultSuccess.new
    else
      ResultError.new(validation.errors)
    end
  end

  private

  attr_reader :user, :params
end
