class AddFieldsToGrowthProfile < ActiveRecord::Migration
  def change
    add_column :growth_profiles, :book1, :integer
    add_column :growth_profiles, :book2, :integer
    add_column :growth_profiles, :book3grade1, :integer
    add_column :growth_profiles, :book3grade2, :integer
    add_column :growth_profiles, :book3grade3, :integer
    add_column :growth_profiles, :book4, :integer
    add_column :growth_profiles, :book5, :integer
    add_column :growth_profiles, :book6, :integer
    add_column :growth_profiles, :book7, :integer
    add_column :growth_profiles, :book8, :integer
  end
end
