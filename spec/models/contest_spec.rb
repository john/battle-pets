require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(200)}

  pending "spec for contest.api_hash"
end
