Fabricator(:user) do
  email { Faker::Internet.email }
  password "123456"
  client_name { sequence(:client_name) { |i| "a_valid_client_name_#{i}" } }
end
