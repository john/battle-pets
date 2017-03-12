require 'rails_helper'

RSpec.describe FightBattleJob, type: :job do
  subject(:job) { described_class.perform_later( create :battle ) }

  it 'queues the job' do
    expect { job }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'executes perform' do
    perform_enqueued_jobs { job }
  end

  # describe "#perform" do
  #   context "with valid battle" do
  #     let(:battle) { create :battle }
  #
  #     it "populates the battle" do
  #       battle
  #     end
  #   end
  #
  #   context "with invalid battle" do
  #   end
  # end

end
