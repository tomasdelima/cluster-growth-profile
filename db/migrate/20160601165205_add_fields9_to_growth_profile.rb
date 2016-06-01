class AddFields9ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :external_human_resources, :text
  end
end
