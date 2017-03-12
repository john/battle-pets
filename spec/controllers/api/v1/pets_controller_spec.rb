require 'rails_helper'

RSpec.describe Api::V1::PetsController, type: :controller do

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

  # describe "POST #create" do
  #   context "with valid params" do
  #     let(:user) { create :user }
  #     let(:headers) { {'X-AUTH-TOKEN': user.authentication_token, 'ACCEPT': 'application/json'} }
  #     let(:params) { "{\"name\": \"#{Time.now.to_i}\", \"strength\": 1, \"intelligence\": 1, \"speed\": 1, \"integrity\": 1}" }
  #
  #     it "creates a new Pet" do
  #       expect {
  #         request.headers.merge!( headers )
  #         post :create, params: {foo: 'bar'}, session: valid_session
  #       }.to change(Pet, :count).by(1)
  #     end
  #   end
  # end
end
