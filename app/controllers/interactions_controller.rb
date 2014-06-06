class InteractionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def new
    @interaction = Interaction.new
  end

  def create
    # binding.pry
    site = Site.find_or_create_by(url: params["interaction"]["url"])
    @interaction = Interaction.new(int_params)
    @interaction.site_id = site.id
    # if an interaction already exists with the same :time param, then update its :move param
    if Interaction.where(time: @interaction.time, user_id: @interaction.user_id)[0]
      old_interaction = Interaction.where(site_id: @interaction.site_id ,time: @interaction.time, user_id: @interaction.user_id)[0]
      old_interaction.move = @interaction.move
      old_interaction.save!
      redirect_to interactions_path
    else
      if @interaction.save
        redirect_to interactions_path
      else
        redirect_to interaction_path
      end
    end
  end

  def show
    @interaction = Interaction.find(params[:id])
    @coordsArray = parse_coords(@interaction.move)
    @url = Site.find(@interaction.site_id).url
  end

  def combined_interactions_site
    site = Site.find(params[:id]) 
    @interaction = site.interactions.first
    @combined_coords = combine_coords(site.interactions)
    @url = site.url
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
    params.require(:interaction).permit(:move, :time, :user_id, :window_width, :body_height)
  end
end
