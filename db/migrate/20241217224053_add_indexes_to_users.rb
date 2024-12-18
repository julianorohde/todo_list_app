# frozen_string_literal: true

class AddIndexesToUsers < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!
  
  def up
    add_index :users, :email, unique: true, algorithm: :concurrently
  end

  def down
    remove_index :users, :email
  end
end
