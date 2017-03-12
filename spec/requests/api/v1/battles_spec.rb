require 'rails_helper'

RSpec.describe "Battles", type: :request do
  describe "With no token" do
    context "GET /api/1/battles/:id" do
      let(:battle) { create :battle }

      it "returns 401" do
        get api_v1_battle_path(battle)
        expect(response).to have_http_status(401)
      end
    end

    context "POST /api/1/battles" do
      it "returns 401" do
        post api_v1_battles_path, params: {contest: {name: 'foo'}}
        expect(response).to have_http_status(401)
      end
    end

    context "PATCH /api/1/battles/:id" do
      let(:battle) { create :battle }

      it "returns 401" do
        patch api_v1_battle_path(battle)
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

    context "GET /api/1/battles/:id" do
      let(:battle) { create :battle }

      it "returns 401" do
        get api_v1_battle_path(battle)
        expect(response).to have_http_status(401)
      end
    end

    context "POST /api/1/battles" do
      it "returns 401" do
        post api_v1_battles_path, params: {contest: {name: 'foo'}}
        expect(response).to have_http_status(401)
      end
    end

    context "PATCH /api/1/battles/:id" do
      let(:battle) { create :battle }

      it "returns 401" do
        patch api_v1_battle_path(battle)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "With valid token" do

    let(:user) { create :user }
    before :each do
      sign_in user
    end

    context "but non-json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token} }

      context "GET /api/1/battles/:id" do
        let(:battle) { create :battle }

        it "returns 422" do
          get api_v1_battle_path(battle), params: {}, headers: headers
          expect(response).to have_http_status(422)
        end
      end

      context "POST /api/1/battles" do
        it "returns 422" do
          post api_v1_battles_path, params: {contest: {name: 'foo'}}, headers: headers
          expect(response).to have_http_status(422)
        end
      end

      context "PATCH /api/1/battles/:id" do
        let(:battle) { create :battle }

        it "returns 422" do
          patch api_v1_battle_path(battle), params: {}, headers: headers
          expect(response).to have_http_status(422)
        end
      end
    end

    context "and json request" do
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token, 'ACCEPT': 'application/json'} }

      context "GET /api/1/battles/:id" do
        let(:battle) { create :battle }

        it "returns 200" do
          get api_v1_battle_path(battle), headers: headers
          expect(response).to have_http_status(200)
        end
      end

      context "POST /api/1/battles", :vcr do
        it "returns 201" do
          contest = create :contest
          post api_v1_battles_path, params: {battle: {contest_id: contest.id}}, headers: headers
          expect(response).to have_http_status(201)
        end

        it "creates a Battle" do
          contest = create :contest
          post api_v1_battles_path, params: {battle: {contest_id: contest.id}}, headers: headers
          expect(response).to have_http_status(201)
        end

      end
    end

  end
end
