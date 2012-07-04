Fabricator(:ingredient) do
  name "testingredient"
  cookbooks "apache22, mysql5"
  category
  share_folders
  portmappings
  network_config
end
