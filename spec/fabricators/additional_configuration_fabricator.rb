Fabricator(:additional_configuration) do
  name "1024MB RAM"
  value 'config.vm.customize ["modifyvm", :id, "--memory", 1024]'
end




