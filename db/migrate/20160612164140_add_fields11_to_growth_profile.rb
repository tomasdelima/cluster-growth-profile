class AddFields11ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :converted_junior_youth_groups, :integer
    add_column :growth_profiles, :converted_study_circles, :integer
  end
end
