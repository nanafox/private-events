class EventsController < ApplicationController
  before_action :set_creator, only: [:user_events]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :validate_user, only: [:edit, :update, :destroy]

  # GET /events or GET /
  def index
    @events_type = "upcoming"

    # Fetch and normalize parameters
    old_events = params[:old_events] == "true"
    all_events = params[:all_events] == "true"

    if old_events
      @events = Event.past
      @events_type = "past"
    elsif all_events
      @events = Event.order(date: :desc).includes(:creator).load
      @events_type = "all"
    else
      @events = Event.upcoming
    end
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: "Event created successfully"
    else
      flash.now[:alert] = "Event creation failed. Fix the errors and try again!"
      render :new, status: :unprocessable_entity
    end
  end

  # GET /events/creator/me
  def current_user_events
    @events = Event.includes(:creator).where(creator: current_user).load
  end

  # GET /events/creator/:username
  def user_events
    @events = Event.includes(:creator).where(creator: @creator).load
  end

  # GET /events/:id
  def show
  end

  # GET /events/:id/edit
  def edit
  end

  # PATCH | PUT /events/:id
  def update
    if @event.update(event_params)
      redirect_to event_path(@event),
        notice: "Event updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/:id
  def destroy
    if @event.destroy
      redirect_to current_user_events_path, notice: "Event deleted successfully"
    else
      redirect_to current_user_events_path, alert: "Failed to delete event"
    end
  end

  private

  # Set the creator for by the given username if found.
  def set_creator
    @creator = User.find_by(username: params.expect(:username))

    unless @creator
      redirect_to root_path, status: :see_other, alert: "User not found!"
    end

    # if the user is the same as the creator, redirect them to their customized
    # page for listing events and attended events.
    if @creator == current_user
      redirect_to current_user_events_path, status: :see_other
    end
  end

  def event_params
    params.expect(event: [:title, :location, :description, :date])
  end

  def set_event
    @event = Event.find_by(id: params.expect(:id))
    unless @event
      redirect_to root_path, status: :see_other, alert: "Event not found!"
    end
  end

  # Validate that the user is authorized to perform the destructive action.
  def validate_user
    unless current_user.owns_event?(@event)
      redirect_to root_path,
        alert: "You are not authorized to perform this action"
    end
  end

  # def allow_filter
  #   params.permit(:all_events, :old_events)
  # end
end
