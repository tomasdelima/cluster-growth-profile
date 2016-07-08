namespace :import do
  task clear: :environment do
    ActiveRecord::Base.transaction do
      clusters_count = Cluster.count
      cities_count = City.count

      Cluster.destroy_all
      City.destroy_all

      puts ">> #{clusters_count} clusters destroyed"
      puts ">> #{cities_count} cities destroyed"
    end
  end

  task update_clusters: :environment do
    ActiveRecord::Base.transaction do
      new_super_clusters_count = 0
      updated_clusters = []

      growth_stages = {
        'Incipiente': -1,
        'Meta': 0,
        '1º Marco': 1,
        '2º Marco': 2,
      }.with_indifferent_access

      data = CSV.open('db/Mapeamento_de_agrupamentos_sudeste.csv', headers: :first_row).map do |row|
        super_cluster = SuperCluster.find_or_create_by(name: row[4]) if row[4] != 'Sem conjunto'
        {
          name: row[3],
          super_cluster: super_cluster,
          growth_stage: growth_stages[row[5]]
        }
      end.select {|a| a[:name]}

      data.map do |cluster_data|
        updated_clusters << cluster_data[:name] if Cluster.find_by(name: cluster_data[:name]).try(:update_attributes, cluster_data)
      end

      puts ">> #{updated_clusters.compact.uniq.count} clusters updated"
    end
  end

  task create_clusters_and_cities: :environment do
    latin_letters = [
      ['Á', 'á'],
      ['É', 'é'],
      ['Í', 'í'],
      ['Ó', 'ó'],
      ['Ú', 'ú'],
      ['Ç', 'ç'],
      ['Ã', 'ã'],
      ['Ẽ', 'ẽ'],
      ['Ü', 'ü'],
      ['Â', 'â'],
      ['Ê', 'ê'],
      ['Ô', 'ô'],
      ['À', 'à'],
    ]

    data = CSV.open('db/Mapeamento_de_agrupamentos_sudeste.csv', headers: :first_row).reduce({}) do |memo, row|
      cluster = row[3]
      city = row[1].titleize

      latin_letters.each do |ll|
        city = city.gsub(ll[0], ll[1])
        city[0] = city[0].gsub(ll[1], ll[0])
      end

      if(memo[cluster])
        memo[cluster] << city
      else
        memo[cluster] = [city]
      end
      memo
    end

    ActiveRecord::Base.transaction do
      new_clusters_count = 0
      new_cities_count = 0

      data.map do |cluster_name, cities_name|
        cluster = Cluster.find_or_create_by(name: cluster_name) do
          new_clusters_count += 1
        end

        cities_name.each do |city_name|
          City.find_or_create_by(name: city_name, cluster: cluster) do
            new_cities_count += 1
          end
        end
      end

      puts ">> #{new_clusters_count - 1} clusters created"
      puts ">> #{new_cities_count} cities created"
    end
  end
end
