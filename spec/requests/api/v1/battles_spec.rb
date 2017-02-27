require 'rails_helper'

RSpec.describe "Battles", type: :request do
  describe "POST /api/1/battles" do
    it "401s without auth" do
      contest = Contest.create(name: 'new contest')
      post api_v1_battles_path, params: {battle: {contest_id: contest.id}}
      expect(response).to have_http_status(401)
    end
  end
end
