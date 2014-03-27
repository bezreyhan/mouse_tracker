class SitesController < ApplicationController
  def new
  end

  def create
  end

  def destroy
  end

  def show
    @site = Site.find(params[:id])
  end

  def index
    @sites = User.find(current_user.id).sites
  end
end
