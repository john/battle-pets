require 'rails_helper'

RSpec.describe Pet, type: :model do

  describe ".get_json_from_api", :vcr do
    it "should not raise an error" do
      expect(Pet.get_json_from_api).to be_a String
    end
  end

  describe ".refresh_from_api", :vcr do
    it "should create new Pet objects" do
    end
  end

end
