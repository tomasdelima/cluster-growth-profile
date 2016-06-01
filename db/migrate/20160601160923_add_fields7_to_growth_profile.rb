class AddFields7ToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :concrete_actions, :text
  end
end
