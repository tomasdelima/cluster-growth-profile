require 'rails_helper'

RSpec.describe GrowthProfile, type: :model do
  describe "#gregorian_cycle" do
    let(:growth_profile) { GrowthProfile.new }

    it "returns the correct value for every cycle" do
      {
        "172-1": {beginning_of_cycle: "Abril 2015",   end_of_cycle: "Julho 2015"},
        "172-2": {beginning_of_cycle: "Julho 2015",   end_of_cycle: "Outubro 2015"},
        "172-3": {beginning_of_cycle: "Outubro 2015", end_of_cycle: "Janeiro 2016"},
        "172-4": {beginning_of_cycle: "Janeiro 2016", end_of_cycle: "Abril 2016"},
        "173-1": {beginning_of_cycle: "Abril 2016",   end_of_cycle: "Julho 2016"},
        "173-2": {beginning_of_cycle: "Julho 2016",   end_of_cycle: "Outubro 2016"},
        "173-3": {beginning_of_cycle: "Outubro 2016", end_of_cycle: "Janeiro 2017"},
        "173-4": {beginning_of_cycle: "Janeiro 2017", end_of_cycle: "Abril 2017"},
      }.each do |k, v|
        expect(GrowthProfile.new(cycle: k).gregorian_cycle).to eq v
      end
    end
  end
end
