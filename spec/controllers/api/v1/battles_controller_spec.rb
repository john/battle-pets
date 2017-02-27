require 'rails_helper'

RSpec.describe Api::V1::BattlesController, type: :controller do

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
      let(:user) { create :user }

      it "creates a new Battle" do
        contest = Contest.create(name: 'testcon')
        expect {
          request.headers.merge!({'X-AUTH-TOKEN': 'abc123'})
          post :create, params: {battle: {contest_id: contest.id}}, session: valid_session
        }.to change(Battle, :count).by(1)
      end
    end
  end
end