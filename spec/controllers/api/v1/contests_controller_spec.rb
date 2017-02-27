require 'rails_helper'

RSpec.describe Api::V1::ContestsController, type: :controller do

  let(:valid_attributes) {
    {name: 'Feats of Strength', description: 'Only the strong survive.', algorithm: 'a+b=c'}
  }

  let(:valid_session) { {} }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
  end

  describe "GET #index" do
    context "with no auth" do
      it "returns 401 unauthorized" do
        get :index, params: {}, session: valid_session
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      # let(:user) { create :user }
      it "creates a new Contest" do
  #       expect {
  #         request.headers.merge!({'X-AUTH-TOKEN': user.authentication_token})
  #         post :create, params: {contest: valid_attributes}, session: valid_session
  #       }.to change(Contest, :count).by(1)
      end
    end
end
end