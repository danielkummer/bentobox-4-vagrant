# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


webserver = Category.create!(name: "Webserver")
wcms = Category.create!(name: "WCMS")
tools = Category.create!(name: "Tools")

ubuntu = Vagrantbox.create!(name: "ubuntu 11.10 server amd64", path: "/usr/public/ubuntu.box")
centos = Vagrantbox.create!(name: "centos 5.5", path: "/usr/public/centos.box")

Ingredient.create!(name: "Apache22", category: webserver, snippet: "some snippet")
Ingredient.create!(name: "Day Communique 5.4", category: wcms, snippet: "some snippet")
Ingredient.create!(name: "Day Communique 5.5", category: wcms, snippet: "some snippet")
Ingredient.create!(name: "Magnolia 4.5", category: wcms, snippet: "some snippet")

User.create!(name: "Bob")
User.create!(name: "Ryan")