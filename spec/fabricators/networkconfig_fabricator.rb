Fabricator(:networkconfig) do
  type "hostonly"
  second_parameter "123.123.123.123"
  third_parameter ""

  ingredient { Fabricate(:ingredient) }
end
