namespace :import do
  task clean: :environment do
    ActiveRecord::Base.transaction do
      clusters_count = Cluster.count
      cities_count = City.count

      Cluster.destroy_all
      City.destroy_all

      puts ">> #{clusters_count} clusters destroyed"
      puts ">> #{cities_count} cities destroyed"
    end
  end

  task clusters_and_cities: :environment do
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

    data = CSV.open('db/Mapeamento_de_agrupamentos_sudeste.csv').reduce({}) do |memo, row|
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

      puts ">> #{new_clusters_count} clusters created"
      puts ">> #{new_cities_count} cities created"
    end
  end
end
