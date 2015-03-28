class MeetsController < ApplicationController

  before_action :require_meet!, only: [ :show, :kick_all ]

  def index
    @meets = Meet.all
  end

  def p
    @meet = Meet.phone_number(params[:id]).includes(phones: [ :key_maps ]).first
    render layout: false if request.xhr?
  end

  def show
    render layout: false if request.xhr?
  end

  def kick_all
    MeetsWrapper.kick_all(params[:id])
    render text: 'ok', layout: false
  end

end
