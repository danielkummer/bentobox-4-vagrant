Fabricator(:networkconfig) do
  type "hostonly"
  second_parameter "123.123.123.123"
  third_parameter ""
end


Fabricator(:networkconfig_with_parent, from: :networkconfig) do
  ingredient { |networkconfig| Fabricate(:ingredient, parent: networkconfig) }
end


