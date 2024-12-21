# frozen_string_literal: true

require "test_helper"

class TodoTest < ActiveSupport::TestCase
  context "#valid?" do
    should validate_presence_of(:title)
    should validate_length_of(:title).is_at_most(40)
  end

  context "associations" do
    should belong_to(:user)
  end

  context "status enum" do
    should "have correct enum values" do
      assert_equal 0, Todo.statuses[:pending]
      assert_equal 1, Todo.statuses[:complete]
    end

    should "respond to enum methods" do
      todo = build(:todo, status: :pending, user: create(:user))

      assert todo.pending?
      todo.complete!
      assert todo.complete?
    end
  end

  context "validations" do
    should "require a title" do
      todo = build(:todo, title: nil, user: create(:user))

      assert_not todo.valid?
      assert_includes todo.errors[:title], "can't be blank"
    end

    should "not allow titles longer than 40 characters" do
      todo = build(:todo, title: Faker::Lorem.characters(number: 41), user: create(:user))

      assert_not todo.valid?
      assert_includes todo.errors[:title], "is too long (maximum is 40 characters)"
    end
  end
end
