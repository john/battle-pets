require 'rails_helper'

RSpec.describe Battle, type: :model do
  it { should have_many(:pets).through(:participants) }
  it { should belong_to(:contest) }
end
