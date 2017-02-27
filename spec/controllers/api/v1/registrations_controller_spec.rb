require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do

  let(:valid_attributes) {
    {email: 'foo@bar.com', name: 'bob'}
  }

  let(:valid_session) { {} }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
  end

  describe "POST #create" do
    context "with valid params" do

      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

    end
  end
end
