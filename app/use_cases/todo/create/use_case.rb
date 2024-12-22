# frozen_string_literal: true

class Todo::Create::UseCase
  def self.call(user: nil, params: nil)
    new(user: user, params: params).call
  end

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    validation = Todo::Create::Validation.new(user: user, params: params)

    if validation.valid?
      todo = Todo.create(params.merge(user: user))

      ResultSuccess.new
    else
      ResultError.new(validation.errors)
    end
  end

  private

  attr_reader :user, :params
end
