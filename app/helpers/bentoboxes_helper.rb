module BentoboxesHelper
  def config_vm_box_name
    ("config.vm.box = \"" + current_user.email + "_" + @bentobox.name.gsub(' ', '_') + "_" + @bentobox.vagrantbox.name.gsub(' ', '_') + "_" + SecureRandom.hex(4) + "\"").html_safe
  end

  def config_vm_box_url
    ("config.vm.box_url = \"" + root_url.chop + @bentobox.vagrantbox.box.url + "\"").html_safe
  end

  def config_network
    result = ""
    first_record = true
    @bentobox.ingredients.with_network_config.each do |box_with_config|
      result << "#" if !first_record
      result << "config.vm.network = " + box_with_config.networkconfig.to_s
      first_record = false
    end
    result << "# No vm.network configuration found - check your ingredients for one..." if result.empty?
    result
  end

  def config_portmapping
    result = ""
    @bentobox.ingredients.each do |ingredient|
      ingredient.portmappings.each do |map|
        result << "config.vm.forward_port #{map.mapping}\n  "
      end
    end
    result << "# No vm.forward_port configuration found - check your ingredients for one..." if result.empty?
    result
  end

  def config_share_folders
    result = ""
    @bentobox.ingredients.where(:share_folders.ne => "", :share_folders.exists => true).each do |ingredient|
      ingredient.share_folders.each do |sf|
        result << "config.vm.share_folder #{sf.logical_name}, #{sf.host_path}, #{sf.guest_path}"
        result << ", #{sf.additional_options}" unless sf.additional_options.blank?
        result << "\n  "
      end
    end
    result.html_safe
  end

  def config_recipes
    result = ""
    @bentobox.ingredients.where(:cookbooks.ne => "", :cookbooks.exists => true).each do |ingredient|
      ingredient.cookbooks.each do |cookbook|
        result << "chef.add_recipe(\"#{cookbook.strip}\")\n    "
      end
    end
    result.html_safe
  end

end
