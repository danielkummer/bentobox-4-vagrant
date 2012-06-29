class PortmappingsController < ApplicationController
  def create
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient.portmappings.create!(params[:portmapping])


    redirect_to @ingredient, :notice => "Portmapping created!"
  end
end
