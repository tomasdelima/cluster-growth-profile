class CreateGrowthProfiles < ActiveRecord::Migration
  def change
    create_table :growth_profiles do |t|
      t.string :cycle
      t.references :cluster, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
