class Officials::EventsController < ApplicationController
  before_action :set_event, only: [:show, :new, :destroy, :edit]

  def index
    @events = Event.all
  end

  def show

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit()
    end
end
