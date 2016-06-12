class AddAccumulatedPyramidToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :accumulated_pyramid, :text
    add_column :growth_profiles, :growth_pyramid, :text
  end
end
