class Officials::SectionsController < ApplicationController
  before_action :set_section

  def show
    @event = Event.find(params[:event_id])
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
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params

    end
end
