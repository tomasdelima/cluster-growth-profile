class Cluster < ActiveRecord::Base
  def to_json
    {
      name:            name,
      growth_stage:    growth_stage,
      counsil_name:    counsil_name,
      geographic_size: geographic_size,
      population_size: population_size,
    }.to_json
  end
end
