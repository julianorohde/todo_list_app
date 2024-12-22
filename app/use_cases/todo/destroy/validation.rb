# frozen_string_literal: true

class Todo::Destroy::Validation
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :user, :todo

  validates :user, presence: true
  validates :todo, presence: true

  validate :validate_user_ownership

  private

  def validate_user_ownership
    errors.add(:base, 'You are not authorized to delete this Todo!') if todo.user != user
  end
end
