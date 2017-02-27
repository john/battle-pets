RSpec.describe Api::V1::ContestsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/api/v1/contests").to route_to("api/v1/contests#create")
    end
  end
end