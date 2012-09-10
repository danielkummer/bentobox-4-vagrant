webserver = Category.create!(name: "Webserver")
wcms = Category.create!(name: "WCMS")
db = Category.create!(name: "Databases")

ubuntu = Vagrantbox.create!(name: "ubuntu 11.10 server amd64", :box => File.open(File.join(Rails.root, 'spec', 'support', 'files', 'example.box')))
Ingredient.create!(name: "Apache2", category: webserver, cookbooks: ["apache2"])
Ingredient.create!(name: "MySQL", category: db, cookbooks: ["mysql5"])
Ingredient.create!(name: "Day Communique 5.5", category: wcms, cookbooks: ["apache2", "mysql5"])
Ingredient.create!(name: "Magnolia 4.5", category: wcms, cookbooks: ["magnolia4.5", "tomcat7"])
network = Ingredient.create!(name: "Something with networkconfig", category: webserver)
network.build_networkconfig(type: "hostonly", second_parameter: "33.33.33.1", ingredient: network)
network.save!

shared_folders = Ingredient.create!(name: "Something with shared folders", category: webserver)
shared_folders.share_folders.push(ShareFolder.new(logical_name: "logical", host_path: "/host", guest_path: "/guest"))
shared_folders.save!

ports = Ingredient.create!(name: "Something with portmappings", category: webserver)
ports.portmappings.push(Portmapping.new(mapping: "80:8080"))
ports.save!


AppConfiguration.put('validation.pem', 'LOAD THE KEY FILE!')
AppConfiguration.put('validation client name', 'chef-validator')
AppConfiguration.put('chef client node name', 'bentobox')
AppConfiguration.put('chef client key', 'config/production.pem')
AppConfiguration.put('chef server api url', 'http://localhost:4000')
AppConfiguration.put('chef server admin url', 'http://localhost:4040')
