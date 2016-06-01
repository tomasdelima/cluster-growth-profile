class AddFields5ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :homes_visited_for_deepening_count, :integer
    add_column :growth_profiles, :sites_with_19_days_feasts_count, :integer
    add_column :growth_profiles, :participants_of_19_days_feasts_count, :integer
    add_column :growth_profiles, :sites_with_holidays_celebrantions_count, :integer
    add_column :growth_profiles, :participants_of_holidays_count, :integer
  end
end
