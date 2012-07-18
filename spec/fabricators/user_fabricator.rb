Fabricator(:users) do
  email { Faker::Internet.email }
  password "123456"
end
