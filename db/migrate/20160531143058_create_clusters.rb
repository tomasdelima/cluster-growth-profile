class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.string :name
      t.string :growth_stage
      t.string :counsil_name
      t.string :abm_names
      t.integer :cabc_count
      t.integer :cce_count
      t.integer :cgpj_count
      t.integer :cia_count
      t.integer :geographic_size
      t.integer :lsa_count
      t.integer :population_size
      t.integer :sites_with_believers_count

      t.timestamps null: false
    end
  end
end
