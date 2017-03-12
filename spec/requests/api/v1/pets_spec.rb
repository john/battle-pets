require 'rails_helper'

RSpec.describe "Pets", type: :request do

  describe "With no token" do
    context "POST /api/1/pets" do
      it "returns 401" do
        post api_v1_pets_path, params: {pet: {name: 'Linda', uuid: 'abc123'}}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "With bad token" do
    let(:user) { create :user }
    let(:headers) { {'X-AUTH-TOKEN': 'badtokenbadbadtoken', 'ACCEPT': 'application/json'} }

    before :each do
      sign_in user
    end

    context "POST /api/1/pets" do
      it "returns 401" do
        post api_v1_pets_path, params: {pet: {name: 'Linda', uuid: 'abc123'}}, headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "With valid token" do
    let(:user) { create :user }
    let(:params) { "{\"name\": \"#{Time.now.to_i}\", \"strength\": 1, \"intelligence\": 1, \"speed\": 1, \"integrity\": 1}" }
    before :each do
      sign_in user
    end

    context "but non-json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token} }

      context "POST /api/1/pets" do
        it "returns 422" do
          post api_v1_pets_path, params: params, headers: headers
          expect(response).to have_http_status(422)
        end
      end
    end

    # This should be posting json to the endpoint, which internally will call the wonder API
    # and create the pet specified.
    context "and json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token, 'CONTENT-TYPE': 'application/json', 'ACCEPT': 'application/json'} }

      context "POST /api/1/pets", :vcr do
        it "returns 201" do
          post api_v1_pets_path, params: params, headers: headers
          expect(response).to have_http_status(201)
        end
      end
  end
  end
end