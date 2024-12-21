# frozen_string_literal: true

require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  context "ApplicationController Test" do
    context "#configure_permitted_parameters method" do
      should "permit custom parameters during sign up" do
        params = { user: { name: 'Test', email: 'test@example.com', password: 'password123' } }

        post user_registration_path, params: params

        assert_response :redirect
      end

      should "not permit custom parameters during sign up" do
        params = { user: { title: 'Test' } }

        post user_registration_path, params: params

        assert_response :unprocessable_entity
      end
    end
  end
end
