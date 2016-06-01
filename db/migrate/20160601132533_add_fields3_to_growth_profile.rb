class AddFields3ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :expansion_phase_involved_count, :integer
    add_column :growth_profiles, :expansion_phase_non_bahais_count, :integer
    add_column :growth_profiles, :children_and_junior_youth_registered_count, :integer
    add_column :growth_profiles, :new_believers_involved_count, :integer
  end
end
