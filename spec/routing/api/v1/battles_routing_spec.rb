RSpec.describe Api::V1::BattlesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/api/v1/battles").to route_to("api/v1/battles#create")
    end
  end
end