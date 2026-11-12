class SquadController < ApplicationController
  before_action :set_squad, only: [:show, :edit]

  def edit
    authorize @squad
    @squadTotalContribution = find_squad_total_contribution
    @squadmember = @squad.squadmembers.find_by!(user: current_user)
    render 'squad/edit'
  end

  #AJAX REQUEST
  def create
    @squad = Squad.new(user: current_user)
    authorize @squad
    ids = Array(params[:chosenVenues]).map(&:to_s)
    venues = Venue.where(id: ids)
    if ids.empty? || ids.uniq.size != ids.size || venues.count != ids.size
      return render json: { error: 'Select valid, distinct venues' }, status: :unprocessable_entity
    end
    Squad.transaction do
      @squad.save!
      venues.each { |venue| @squad.squadchosenvenues.create!(venue: venue) }
      @squad.squadmembers.create!(user: current_user, contribution: 0)
    end
    render json: @squad
  end

  def add_sidekick
    @squad = Squad.find(params[:id])
    @squadmember = Squadmember.new
    @searchBar = true;

    authorize @squad
  end

  def member_choose_venue
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember
  end

  def member_confirm_venue
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember

    choice = @squad.squadchosenvenues.find_by(id: params[:squadchosenvenue_id])
    return render json: { error: 'Invalid venue choice' }, status: :unprocessable_entity unless choice
    @squadmember.update!(squadchosenvenue: choice)

    if true #passed validations
      render json: { squad: @squad, squadmembers: @squad.squadmembers, status: venue_progess_ready? }
    else
      render json: '????'
    end
  end

  def choose_venue_status
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find_by(user: current_user)
    authorize @squadmember

    render json: { squad: @squad, squadmembers: @squad.squadmembers, status: venue_progess_ready? }
  end

  def member_choose_contribution
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])
    authorize @squadmember
    @squadChosenVenue = find_squad_chosen_venue
    return redirect_to member_choose_venue_path(@squad, @squadmember), alert: 'Choose a venue first.' unless @squadChosenVenue
  end

  def member_confirm_contribution
    @squad = Squad.find(params[:id])
    @squadmember = @squad.squadmembers.find(params[:squad_member_id])

    authorize @squadmember

    if params[:currentaction] != 'status'
      # binding.pry
      contribution = Integer(params[:contribution].to_s, exception: false)
      return render json: { error: 'Contribution must be a positive whole number' }, status: :unprocessable_entity unless contribution && contribution > 0
      @squadmember.update!(contribution: contribution, will_be_present: true)

    end
    # binding.pry
    render json: { squad: @squad, squadmembers: @squad.squadmembers, status: contribution_progess_ready? }
  end

  #AJAX REQUESTS
  def refresh_squad_status
    @squad = Squad.find(params[:id])
    #add api logic
  end

  #AJAX REQUESTS

  #AJAX REQUESTS
  def update
    @squad = Squad.find(params[:id])
    authorize @squad
    user = params[:adding_user_id].present? ? User.find_by(id: params[:adding_user_id]) : User.find_by(email: params[:email])
    return head :unprocessable_entity unless user
    @squadmember = @squad.squadmembers.new(user: user, contribution: 0)
    return head :unprocessable_entity unless @squadmember.save
    respond_to { |format| format.js }
  end

  #AJAX REQUESTS

  def confirm_squad_member
    @squad = Squad.find(params[:id])
    squadmember = @squad.squadmembers.find_by!(user: current_user)
    authorize squadmember
    choice = @squad.squadchosenvenues.find_by(id: params[:squadchosenvenue_id])
    contribution = Integer(params[:contribution].to_s, exception: false)
    return render json: { error: 'Invalid selection' }, status: :unprocessable_entity unless choice && contribution && contribution > 0
    squadmember.update!(squadchosenvenue: choice, contribution: contribution, will_be_present: params[:will_be_present])
    render json: @squad
  end

  def show
    @squad = Squad.find(params[:id])
    authorize @squad
    @squadChosenVenue = find_squad_chosen_venue
    unless @squadChosenVenue
      member = @squad.squadmembers.find_by(user: current_user)
      return redirect_to(member_choose_venue_path(@squad, member), alert: 'Choose a venue first.') if member
      return head :unprocessable_entity
    end
    @squadTotalContribution = find_squad_total_contribution
    @yourContribution = @squad.squadmembers.find_by(user: current_user)&.contribution.to_i
  end

  # AJAX REQUESTS
  def confirm_squad_order
    # TODO : add some booking logic + return JS to display confirmation report
    @squad = Squad.find(params[:id])
    authorize @squad

    @squad.update(confirmed: true)


    respond_to do |format|
      format.js
    end

  end

  # AJAX REQUESTS
  def update_package
    @squad = Squad.find(params[:id])
    authorize @squad
    chosen = find_squad_chosen_venue
    return head :unprocessable_entity unless chosen
    @package = chosen.venue.packages.find_by(id: params[:package_id])
    return head :unprocessable_entity unless @package
    @squad.update!(package: @package)

    respond_to do |format|
      format.js
    end
  end

  private

  def params_update_package
    params.require(:squad).permit(:package_id)
  end

  def params_finalize_squad
    # 601:  TODO : fire only when leader clicks on button to go to show page.
    # it's been decided :
    # => jscript will return squadchosenvenue_id of the venue with the highest vote counter on 601 submit
    params.require(:squad).permit(:squadchosenvenue_id)

  end

  def extract_squad_chosen_venues
    #TODO : receive JS http request
  end

  def extract_squad_member
    #TODO : receive JS http requeset and extract squad member
    # params.require(:squadmember).permit(:user)
  end

  def set_squad
    @squad = Squad.find(params[:id])
  end

  def find_squad_chosen_venue
    vote_results = {}
    @squad.squadmembers.each do |squadmember|
      unless squadmember.squadchosenvenue_id.nil?
        if vote_results[squadmember.squadchosenvenue_id]
          vote_results[squadmember.squadchosenvenue_id] += 1
        else
          vote_results[squadmember.squadchosenvenue_id] = 1
        end
      end
    end
    vote_result = vote_results.max_by{|k,v| v}
    vote_result && @squad.squadchosenvenues.find_by(id: vote_result[0])
  end

  def find_squad_total_contribution
    contribution = 0;

    @squad.squadmembers.each do |squadmember|
      unless squadmember.contribution.nil?
        contribution += squadmember.contribution
      end
    end

    return contribution

  end

  def venue_progess_ready?
    #todo : calculate if more then half of people have voted yet

    member_count = @squad.squadmembers.count
    member_critial_count = (@squad.squadmembers.count/2.to_f).ceil
    # member_critial_count = member_count - 1
    members_have_not_chosen = []

    member_count_have_chosen_venue = 0

    @squad.squadmembers.each do |squadmember|
      if squadmember.squadchosenvenue_id.nil?
        members_have_not_chosen << squadmember
      else
        member_count_have_chosen_venue += 1
      end
    end

    return { ready: member_critial_count <= member_count_have_chosen_venue, missing_cnt: member_critial_count - member_count_have_chosen_venue, waiting_for: members_have_not_chosen }
  end

  def contribution_progess_ready?
    #todo : calculate if more then half of people have voted yet

    member_count = @squad.squadmembers.count
    member_critial_count = member_count
    members_have_not_contributed = []

    member_count_have_contributed = 0

    @squad.squadmembers.each do |squadmember|
      if squadmember.contribution == 0 || squadmember.contribution.nil?
        members_have_not_contributed << squadmember
      else
        member_count_have_contributed += 1
      end
    end

    return { ready: member_count == member_count_have_contributed, missing_cnt: member_critial_count - member_count_have_contributed, waiting_for: members_have_not_contributed }
  end



end
