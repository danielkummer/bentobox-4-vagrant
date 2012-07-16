class WelcomeController < ApplicationController
  skip_filter :authenticate_user!, only: [:index]

  def index
    a = ChefClient.new
    @cookbooks = a.list
  end
end
