class UpdatesController < ApplicationController
  def index
    @bentoboxes = current_user.owned_boxes
  end
end
