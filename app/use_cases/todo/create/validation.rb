# frozen_string_literal: true

class Todo::Create::Validation
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :user, :params

  validates :user, presence: true
  validates :params, presence: true

  validate :validate_title
  validate :validate_status

  private

  def validate_title
    if params[:title].blank?
      errors.add(:base, 'Title cannot be blank!')
    elsif params[:title].size > 40
      errors.add(:base, 'Title is too long! Maximum is 40 characters.')
    end
  end

  def validate_status
    errors.add(:base, 'The status cannot be "completed" when creating a Todo!') if params[:status] == 'complete'
  end
end
