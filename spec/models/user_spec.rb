require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_length_of(:name).is_at_most(200)}
  it { should validate_length_of(:email).is_at_most(200)}
end
