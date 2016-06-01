class AddFields4ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :children_count, :integer
    add_column :growth_profiles, :junior_youth_count, :integer
    add_column :growth_profiles, :youth_count, :integer
    add_column :growth_profiles, :men_count, :integer
    add_column :growth_profiles, :women_count, :integer
  end
end
