class EventsController < ApplicationController
  include ApiResponder
  before_action :set_event, only: %i[show update destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render_success({ event: serialized_json(@event) }, 'Event rendered successfully.')
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      render_success({ event: serialized_json(@event) }, 'Event created successfully.')
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render_success({ event: serialized_json(@event) }, 'Event updated successfully.')
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    render_success({ event: serialized_json(event) }, 'Event destroyed successfully.')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    # params.fetch(:event, {})
    params.require('event').permit(:name)
  end

  def serialized_json(details)
    EventSerializer.new(details).serializable_hash[:data]
  end
end
