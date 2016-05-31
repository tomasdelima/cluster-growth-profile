class AddOtherFieldsToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :devotional_gathering_count, :integer
    add_column :growth_profiles, :devotional_gathering_participants, :integer
    add_column :growth_profiles, :devotional_gathering_non_bahai_friends, :integer
    add_column :growth_profiles, :children_classes_count, :integer
    add_column :growth_profiles, :children_classes_participants, :integer
    add_column :growth_profiles, :children_classes_non_bahai_friends, :integer
    add_column :growth_profiles, :junior_youth_group_count, :integer
    add_column :growth_profiles, :junior_youth_group_participants, :integer
    add_column :growth_profiles, :junior_youth_group_non_bahai_friends, :integer
    add_column :growth_profiles, :study_circle_count, :integer
    add_column :growth_profiles, :study_circle_participants, :integer
    add_column :growth_profiles, :study_circle_non_bahai_friends, :integer
  end
end
