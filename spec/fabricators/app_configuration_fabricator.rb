Fabricator(:app_configuration) do
  name { Faker::Lorem.word }
  value { Faker::Lorem.word }
end
