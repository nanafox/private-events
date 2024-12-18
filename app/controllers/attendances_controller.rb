class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_attendance, only: [ :destroy ]

  def create
    @attendance = @event.attendances.find_or_create_by(attendee: current_user)

    respond_to do |format|
      format.html { redirect_to @event } # Fallback for non-JS users
      format.turbo_stream
    end
  end

  def destroy
    if @attendance
      @attendance.destroy
    end

    respond_to do |format|
      format.html { redirect_to @event } # Fallback for non-JS users
      format.turbo_stream
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendance
    @attendance = Attendance.find_by(id: params[:id])
  end
end
