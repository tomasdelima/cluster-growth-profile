class Cluster < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :growth_profiles
  has_many :cities

  def to_json
    {
      abm_names:       abm_names,
      cabc_count:      cabc_count,
      cce_count:       cce_count,
      cgpj_count:      cgpj_count,
      cia_count:       cia_count,
      counsil_name:    counsil_name,
      geographic_size: geographic_size,
      growth_stage:    growth_stage,
      id:              id,
      lsa_count:       lsa_count,
      name:            name,
      population_size: population_size,
      sites_with_believers_count: sites_with_believers_count,
    }.to_json
  end

  def current_cycle
    today = Date.today

    cycle_number = 1
    cycle_number += 1 if today >= Date.new(today.year, 7, 20)
    cycle_number += 1 if today >= Date.new(today.year, 10, 20)
    cycle_number += 1 if today >= Date.new(today.year + 1, 1, 20)

    year = ((today - Date.new(1844, 4, 20)).days/1.year).ceil

    {cycle: cycle_number, year: year}
  end
end
