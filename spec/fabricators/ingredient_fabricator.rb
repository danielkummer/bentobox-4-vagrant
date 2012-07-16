Fabricator(:ingredient) do
  name { Faker::Product.brand }
  #name { sequence(:name) { |i| "ingredient #{i}" } }
  cookbooks ['apache22', 'mysql5']
  category { Fabricate(:category) }
end


Fabricator(:full_ingredient, from: :ingredient) do
  after_create do |ingredient|
    ingredient.share_folders << Fabricate(:share_folder, ingredient: ingredient)
    ingredient.portmappings << Fabricate(:portmapping, ingredient: ingredient)
    ingredient.networkconfig << abricate(:networkconfig, ingredient: ingredient)
  end
  #share_folders(count: 1) { |ingredient| Fabricate(:share_folder, ingredient: ingredient) }
  #portmappings(count: 1) { |ingredient| Fabricate(:portmapping, ingredient: ingredient) }
  #networkconfig { |ingredient| Fabricate(:networkconfig, ingredient: ingredient) }
end

