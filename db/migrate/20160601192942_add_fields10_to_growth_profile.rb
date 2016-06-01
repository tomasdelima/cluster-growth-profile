class AddFields10ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :active_internal_human_resources, :text
  end
end
