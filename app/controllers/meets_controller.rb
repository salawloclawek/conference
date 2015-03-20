class MeetsController < ApplicationController

  def index
    @meets = Meet.all
  end

  def show
    @meet = Meet.where(identifier: params[:id]).first
    render layout: false if request.xhr?
  end

end
