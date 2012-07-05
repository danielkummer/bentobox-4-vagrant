Fabricator(:ingredient) do
  name "testingredient"
  cookbooks "apache22, mysql5"
  category { Fabricate(:category) }
  share_folders(count:1) { |ingredient| Fabricate(:share_folder, parent: ingredient) }
  portmappings(count:1)
  networkconfig { |ingredient| Fabricate(:networkconfig, parent: ingredient) }
end
