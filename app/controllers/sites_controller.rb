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
    @sites = User.find(current_user.id).sites
  end

  def site_interactions
    # eventually this should only be interactions for the current_user,
    # rather than all the interactions for a given site. 
    # something like Interaction.where(user_id: current_user.id && site_id: params[:id])
    @site_interactions = Interaction.where(user_id: current_user.id, site_id: params[:id])
  end

end
