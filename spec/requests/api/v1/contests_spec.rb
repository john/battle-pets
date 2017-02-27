require 'rails_helper'

RSpec.describe "Contests", type: :request do
  describe "POST /api/1/contests" do
    it "401s without auth" do
      # contest = Contest.create(name: 'new contest')
      post api_v1_contests_path, params: {contest: {name: 'foo'}}
      expect(response).to have_http_status(401)
    end
  end
end
