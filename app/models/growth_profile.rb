class GrowthProfile < ActiveRecord::Base
  belongs_to :cluster

  def to_json
    {
      cycle: cycle,
    }.to_json
  end
end
