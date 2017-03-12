require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { should belong_to(:move) }
end
