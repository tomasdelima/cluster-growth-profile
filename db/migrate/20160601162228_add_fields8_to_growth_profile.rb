class AddFields8ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :team_people, :string
    add_column :growth_profiles, :visits_count, :string
    add_column :growth_profiles, :visit_mean_duration, :string
    add_column :growth_profiles, :consultation_center, :string
  end
end
