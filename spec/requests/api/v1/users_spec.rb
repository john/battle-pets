require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /api/1/users" do
    # let(:user) { create :user }

    it "creates new user" do
      # user = create(:admin_user)
      # sign_in user

      post api_v1_user_registration_path, params: {user: {email: 'foo@bar.com', name: 'bob'}}
      expect(response).to have_http_status(200)
    end
  end
end
