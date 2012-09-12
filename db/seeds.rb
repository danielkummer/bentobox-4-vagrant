# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


AdditionalConfiguration.create!(name: "1024MB RAM",value: 'config.vm.customize ["modifyvm", :id, "--memory", 1024]')
AdditionalConfiguration.create!(name: "2048MB RAM",value: 'config.vm.customize ["modifyvm", :id, "--memory", 2048]')