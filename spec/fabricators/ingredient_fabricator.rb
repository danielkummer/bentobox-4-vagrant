Fabricator(:ingredient) do
  name { Faker::Product.brand }
  #name { sequence(:name) { |i| "ingredient #{i}" } }
  cookbooks "apache22, mysql5"
  category { Fabricate(:category) }
  share_folders(count: 1) { |ingredient| Fabricate(:share_folder, ingredient: ingredient) }
  portmappings(count: 1) { |ingredient| Fabricate(:portmapping, ingredient: ingredient) }
  networkconfig { |ingredient| Fabricate(:networkconfig, ingredient: ingredient) }
end
