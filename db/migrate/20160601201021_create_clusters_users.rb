class CreateClustersUsers < ActiveRecord::Migration
  def change
    create_table :clusters_users, id: false do |t|
      t.references :cluster
      t.references :user
    end
  end
end
