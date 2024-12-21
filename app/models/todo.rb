# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, complete: 1 }

  validates :title, presence: true, length: { maximum: 40 }
end
