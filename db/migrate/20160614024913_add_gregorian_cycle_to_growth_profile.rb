class AddGregorianCycleToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :gregorian_cycle, :text
  end
end
