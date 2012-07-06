Fabricator(:bentobox) do
  name "Bentobox"
  description "Description"
  public false
  user { Fabricate(:user) }
  vagrantbox { Fabricate(:vagrantbox) }
  ingredients(count:1) { |parent| Fabricate(:ingredient, bentobox: parent) }
  #  children(count: 3) { |parent, i| Fabricate(:person, parent: parent) }
end
