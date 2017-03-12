require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(200) }
  it { should have_many(:battles) }

  describe "#api_hash" do
    let(:contest) { create :contest }

    it "should return an api_hash" do
      the_hash = contest.api_hash
      expect( the_hash[:id]).to eq(contest.id)
      expect( the_hash[:name]).to eq(contest.name)
      expect( the_hash[:description]).to eq(contest.description)
      expect( the_hash[:algorithm]).to eq(contest.algorithm)
      expect( the_hash[:winning_characteristic]).to eq(contest.winning_characteristic)
    end
  end

end
