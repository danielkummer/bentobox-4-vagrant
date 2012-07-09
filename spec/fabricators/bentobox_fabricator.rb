Fabricator(:bentobox) do
  name "Bentobox"
  description "Description"
  public false
  user { Fabricate(:user) }
  vagrantbox { Fabricate(:vagrantbox) }

end



Fabricator(:bentobox_with_ingredient, from: :bentobox) do
  ingredients(count:2) { |parent| Fabricate(:ingredient, bentobox: parent) }
end