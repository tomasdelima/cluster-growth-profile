class ChangeClusterGeographicSizeType < ActiveRecord::Migration
  def change
    change_column :clusters, :geographic_size,  :float
  end
end
