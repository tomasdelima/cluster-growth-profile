class AddFields6ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :devotional_gathering_frequency, :string
    add_column :growth_profiles, :children_classes_frequency, :string
    add_column :growth_profiles, :junior_youth_group_frequency, :string
    add_column :growth_profiles, :study_circle_frequency, :string
  end
end
