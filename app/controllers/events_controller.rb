class EventsController < ApplicationController
#  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!, only: [:edit, :update, :new, :create]
  # GET /events.json
  def index
    @events = Event.where( "start_at > ?", Time.now )

    if params[:search].present?
      if params[:dist].present? && is_number?(params[:dist])
        @events = @events.near(params[:search], params[:dist], order: 'distance') 
      else
        @events = @events.near(params[:search], 50, order: 'distance') 
#    elsif user_signed_in? && current_user.address
#      @events = Event.near([current_user.latitude, current_user.longitude], 25, order: 'distance') 
#    elsif request.location 
#      @events = Event.near([request.location.latitude, request.location.longitude], 25, order: 'distance') 
#    else
#      @events = Event.near("Washington, DC", 100, order: 'distance')
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def pastevents
    @events = Event.where( "start_at < ?", Time.now )
    if params[:search].present?
      if params[:dist].present? && is_number?(params[:dist])
        @events = @events.near(params[:search], params[:dist], order: 'distance') 
      else
        @events = @events.near(params[:search], 50, order: 'distance') 
      end
    end
  end
  def online
    events = Event.where( "start_at > ?", Time.now )
    @events = events.where( 'address = ?', "online") 
    pastevents = Event.where( "start_at < ?", Time.now )
    @pastevents = pastevents.where( 'address = ?', "online") 
  end

  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @user = User.find(@event.usrid)
    @rsvp = Rsvpq.new
    @rsvpusers = @event.users
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new.json
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events.json
  def create
    @event = current_user.events.build(event_params)

puts @event.start_at
puts @event.start_at.to_f
puts @event.end_at
puts @event.end_at.to_f
puts @event.start_at.to_f + 3.hours.to_f
puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    respond_to do |format|
      if @event.save
#        redirect_to @event
        format.html { redirect_to "/" }
        format.json { render json: @event, status: :created, location: @event }
      else
#        format.html { redirect_to new_event_path }
 #       redirect_to new_event_path, :notice => "Your event was not saved. Check for improper input."
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to @event }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end

  private

    def event_params
      params.require(:event).permit(:address, :name, :start_at, :end_at, :desc, :latitude, :longitude, :usrid, :user_id, :group1id, :group2id, :group3id )
    end

    def is_number?(obj)
      obj.to_s == obj.to_i.to_s
    end

end
