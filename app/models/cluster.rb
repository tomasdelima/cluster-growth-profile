class Cluster < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :growth_profiles

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
