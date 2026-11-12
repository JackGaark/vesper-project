class VenueController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :welcome, :privacy]
  before_action :set_venue, only: [ ]
  def welcome
    @venue = Venue.first
    authorize @venue
  end


  def create
    @venue = Venue.new
    authorize @venue
    # TODO if / else

  end

  def new
    @venue = Venue.new
    authorize @venue
  end

  def edit
    @venue = Venue.find(params[:id])
    authorize @venue
  end

  def update
    @venue = Venue.find(params[:id])
    authorize @venue
    if
      @venue.update(update_venue_params)
      redirect_to venue_path(@venue)
    else
      render "edit"
    end
  end

  def index
    @squad = Squad.new(user: current_user)

    # @Venues = policy_scope(Venue).where.not(latitude: nil, longitude: nil).limit(50)
    @Venues = policy_scope(Venue).limit(50)
    @searchBar = true;
    @markers = @Venues.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        # infoWindow: { content: 'you are here' }
        # infoWindow: { content: render_to_string(partial: "venue/index_components/venue_card", locals: { venue: venue }) }
      }
    end
  end

  def show
    @venue = Venue.find(params[:id])
    authorize @venue

    @markers = [{
      lat: @venue.latitude,
      lng: @venue.longitude
    }]
  end

  def privacy
    @venue = Venue.first
    authorize @venue
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def update_venue_params
    params.require(:venue).permit(:description, :music_genre, :instagram_handle, :pricing, :capacity, :rating, :review_count, :photo)
  end

end
