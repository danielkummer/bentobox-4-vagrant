Fabricator(:ingredient) do
  name { Faker::Product.brand }
  cookbooks ['apache22', 'mysql5']
  category { Fabricate(:category) }
end


Fabricator(:full_ingredient, from: :ingredient) do
  after_create do |ingredient|
    ingredient.share_folders.push Fabricate.build(:share_folder, ingredient: ingredient)
    ingredient.portmappings.push Fabricate.build(:portmapping, ingredient: ingredient)
    ingredient.build_networkconfig Fabricate.build(:networkconfig, ingredient: ingredient)
  end
end

