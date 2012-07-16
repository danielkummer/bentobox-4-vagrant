class AdditionalConfigurationsController < ApplicationController
  respond_to :html


  def index
    @additional_configurations = AdditionalConfiguration.all
    respond_with @additional_configurations
  end

  def new
    @additional_configuration = AdditionalConfiguration.new

    respond_with @additional_configuration
  end


  def edit
    @additional_configuration = AdditionalConfiguration.find(params[:id])
    respond_with @additional_configuration
  end

  def create
    @additional_configuration = AdditionalConfiguration.new(params[:additional_configuration])

    respond_to do |format|
      if @additional_configuration.save
        format.html { redirect_to additional_configurations_url, notice: 'Additional configuration was successfully created.' }
        format.json { render json: @additional_configuration, status: :created, location: @additional_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @additional_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @additional_configuration = AdditionalConfiguration.find(params[:id])

    respond_to do |format|
      if @additional_configuration.update_attributes(params[:additional_configuration])
        format.html { redirect_to additional_configurations_url, notice: 'Additional configuration was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @additional_configuration = AdditionalConfiguration.find(params[:id])
    @additional_configuration.destroy

    respond_to do |format|
      format.html { redirect_to additional_configurations_url }
      format.json { head :no_content }
    end
  end
end
