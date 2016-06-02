user = User.create(email: 'tomasdelima@gmail.com', password: '12345678')
admin = Admin.create(email: 'tomasdelima@gmail.com', password: '12345678')
cluster_1 = Cluster.create(
  abm_names: 'Fulano, Ciclano',
  cabc_count: 1,
  cce_count: 2,
  cgpj_count: 3,
  cia_count: 4,
  counsil_name: 'Sudeste',
  geographic_size: 3000000,
  growth_stage: 'PC',
  lsa_count: 5,
  name: 'Rio de Janeiro',
  population_size: 1000000,
  sites_with_believers_count: 6,
)
cluster_2 = Cluster.create(
  abm_names: 'Fulano, Ciclano',
  cabc_count: 1,
  cce_count: 1,
  cgpj_count: 1,
  cia_count: 2,
  counsil_name: 'Sudeste',
  geographic_size: 450000,
  growth_stage: 'PC',
  lsa_count: 1,
  name: 'Luz da Serra',
  population_size: 32000,
  sites_with_believers_count: 2,
)
user.clusters << cluster_1
user.clusters << cluster_2
