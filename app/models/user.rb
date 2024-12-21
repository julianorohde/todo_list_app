# frozen_string_literal: true

class User < ApplicationRecord
  has_many :todos, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
