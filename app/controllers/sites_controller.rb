class SitesController < ApplicationController
  def new
  end

  def create
  end

  def destroy
  end

  def show
  end

  def index
    @sites = User.find(current_user.id).sites.uniq
  end

  def site_interactions
    @site = Site.find(params[:id])
    @site_interactions = Interaction.where(user_id: current_user.id, site_id: params[:id])
  end

end
