module BentoboxesHelper
  def vm_box_name(bentobox)
    bentobox.vagrantbox.name.gsub(' ', '_')
  end

  def network_config(bentobox)
    bentobox.ingredients.excludes(:network_config => nil).first.network_config.html_safe
  end

  def port_config(bentobox)
    ingredients = bentobox.ingredients
    result = ""

    ingredients.each do |ingredient|
      ingredient.portmappings.each do |map|
        result << "config.vm.forward_port #{map.mapping}\n  "
      end
    end
    result
  end

  def share_folder_config(bentobox)
    result = ""
    bentobox.ingredients.where(:share_folder.ne => "", :share_folder.exists => true).each do |ingredient|
      result << "config.vm.share_folder #{ingredient.share_folder}\n  "
    end
    result.html_safe
  end

  def recepies_config(bentobox)
    result = ""
    bentobox.ingredients.where(:cookbooks.ne => "", :cookbooks.exists => true).each do |ingredient|
      ingredient.cookbooks.split(',').each do |cookbook|
        result << "chef.add_recipe(\"#{cookbook.strip}\")\n    "
      end
    end
    result.html_safe
  end
end
