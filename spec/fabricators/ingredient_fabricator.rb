Fabricator(:ingredient) do
  name "testingredient"
  cookbooks "apache22, mysql5"
  category
  share_folders
  portmappings
  networkconfig { Fabricate(:networkconfig) }
end
