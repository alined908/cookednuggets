class Officials::OfficialsController < ApplicationController
  before_action :set_match, only: [:show, :new, :destroy, :edit]

  def index

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
    def set_match
      @match = Officials.find(params[:id])
    end

    def event_params
      params.require(:match).permit()
    end
end
