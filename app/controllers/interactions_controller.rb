class InteractionsController < ApplicationController

  def new
    @interaction = Interaction.new
  end

  def create
    site = Site.find_or_create_by(url: params["interaction"]["url"])
    @interaction = Interaction.new(int_params)
    @interaction.site_id = site.id
    if @interaction.save
      redirect_to interactions_path
    else
      redirect_to interaction_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @interactions = Interaction.all
  end

  private 

  def int_params
    params.require(:interaction).permit(:move, :time, :user_id)
  end
end
