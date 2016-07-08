class CreateSuperClusters < ActiveRecord::Migration
  def change
    create_table :super_clusters do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
