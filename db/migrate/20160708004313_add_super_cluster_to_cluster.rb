class AddSuperClusterToCluster < ActiveRecord::Migration
  def change
    add_reference :clusters, :super_cluster, index: true, foreign_key: true
  end
end
