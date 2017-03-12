require 'rails_helper'

RSpec.describe Api::V1::BattlesController, type: :controller do

  let(:valid_session) { {} }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
  end

  describe "POST #create" do
    context "with valid params" do
      let(:user) { create :user }
      let(:headers) { {'X-AUTH-TOKEN': user.authentication_token, 'ACCEPT': 'application/json'} }

      it "creates a new Battle" do
        contest = Contest.create(name: 'testcon')
        expect {
          request.headers.merge!( headers )
          post :create, params: {battle: {contest_id: contest.id}}, session: valid_session
        }.to change(Battle, :count).by(1)
      end
    end
  end
end