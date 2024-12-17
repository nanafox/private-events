class EventsController < ApplicationController
  before_action :set_creator, only: [ :user_events ]
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  # GET /events or GET /
  def index
    @events = Event.includes(:creator).load
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
  end

  def event_params
    params.expect(event: [ :title, :location, :description, :date ])
  end

  def set_event
    @event = Event.find_by(id: params.expect(:id))
    unless @event
      redirect_to root_path, status: :see_other, alert: "Event not found!"
    end
  end
end
