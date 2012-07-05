# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


webserver = Category.create!(name: "Webserver")
wcms = Category.create!(name: "WCMS")
db = Category.create!(name: "Databases")

ubuntu = Vagrantbox.create!(name: "ubuntu 11.10 server amd64", :box => File.open(File.join(Rails.root, 'spec', 'support', 'files', 'example.box')))

Ingredient.create!(name: "Apache2", category: webserver, cookbooks: "apache2")
Ingredient.create!(name: "MySQL", category: db, cookbooks: "mysql5")
Ingredient.create!(name: "Day Communique 5.5", category: wcms, cookbooks: "some snippet")
Ingredient.create!(name: "Magnolia 4.5", category: wcms, cookbooks: "some snippet")

