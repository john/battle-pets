require 'rails_helper'

RSpec.describe "Participants", type: :request do

  describe "With no token" do
    let(:battle) { create :battle }
    let(:pet) { create :pet }

    context "POST /api/1/participants" do
      it "returns 401" do
        post api_v1_participants_path, params: {participant: {battle_id: battle.id, pet_id: pet.id}}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "With bad token" do
    let(:user) { create :user }
    let(:headers) { {'X-AUTH-TOKEN': 'badtokenbadbadtoken', 'ACCEPT': 'application/json'} }
    let(:battle) { create :battle }
    let(:pet) { create :pet }

    before :each do
      sign_in user
    end

    context "POST /api/1/participants" do
      it "returns 401" do
        post api_v1_participants_path, params: {participant: {battle_id: battle.id, pet_id: pet.id}}, headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "With valid token" do
    let(:user) { create :user }
    let(:battle) { create :battle }
    let(:pet) { create :pet }
    before :each do
      sign_in user
    end

    context "but non-json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token} }

      context "POST /api/1/participants" do
        it "returns 422" do
          post api_v1_participants_path, params: {participant: {battle_id: battle.id, pet_id: pet.id}}, headers: headers
          expect(response).to have_http_status(422)
        end
      end
    end

    context "and json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token, 'ACCEPT': 'application/json'} }

      context "POST /api/1/participants" do
        it "returns 200" do
          post api_v1_participants_path, params: {participant: {battle_id: battle.id, pet_id: pet.id}}, headers: headers
          expect(response).to have_http_status(200)
        end
      end
    end

  end
end