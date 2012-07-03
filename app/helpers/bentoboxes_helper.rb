module BentoboxesHelper
  def config_vm_box_name
    ("config.vm.box = \"" + current_user.email + "_" + @bentobox.name.gsub(' ', '_') + "_" + @bentobox.vagrantbox.name.gsub(' ', '_') + "_" + ActiveSupport::SecureRandom.hex(4) + "\"").html_safe
  end

  def config_vm_box_url
    ("config.vm.box_url = \"" + root_url.chop + @bentobox.vagrantbox.box.url + "\"").html_safe
  end

  def config_network
    "config.vm.network = " + @bentobox.ingredients.excludes(:network_config => nil).first.network_config.to_s
  end

  def config_portmapping
    ingredients = @bentobox.ingredients
    result = ""

    ingredients.each do |ingredient|
      ingredient.portmappings.each do |map|
        result << "config.vm.forward_port #{map.mapping}\n  "
      end
    end
    result
  end

  def config_share_folders
    result = ""
    @bentobox.ingredients.where(:share_folders.ne => "", :share_folders.exists => true).each do |ingredient|
      ingredient.share_folders.each do |sf|
        result << "config.vm.share_folder #{sf.logical_name}, #{sf.host_path}, #{sf.guest_path}"
        result << ", #{sf.additional_options}" unless sf.additional_options.empty?
        result << "\n  "
      end
    end
    result.html_safe
  end

  def config_recepies
    result = ""
    @bentobox.ingredients.where(:cookbooks.ne => "", :cookbooks.exists => true).each do |ingredient|
      ingredient.cookbooks.split(',').each do |cookbook|
        result << "chef.add_recipe(\"#{cookbook.strip}\")\n    "
      end
    end
    result.html_safe
  end

  private
  def random_hash
    #todo
    "DEADBEEF"
  end
end
