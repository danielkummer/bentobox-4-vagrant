class UpdatesController < ApplicationController
  def index
    @bentoboxes = current_user.bentoboxes
  end
end
