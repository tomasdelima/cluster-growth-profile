class AddFields12ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :youth_conferences_accompaniments, :text
  end
end
