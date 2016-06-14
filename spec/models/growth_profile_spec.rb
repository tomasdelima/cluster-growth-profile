require 'rails_helper'

RSpec.describe GrowthProfile, type: :model do
  describe "#gregorian_cycle" do
    let(:growth_profile) { GrowthProfile.new }

    it "returns the correct value for every cycle" do
      {
        "172-1": "Abril 2015",
        "172-2": "Julho 2015",
        "172-3": "Outubro 2015",
        "172-4": "Janeiro 2016",
        "173-1": "Abril 2016",
        "173-2": "Julho 2016",
        "173-3": "Outubro 2016",
        "173-4": "Janeiro 2017",
      }.each do |k, v|
        expect(GrowthProfile.new(cycle: k).gregorian_cycle).to eq v
      end
    end
  end
end
