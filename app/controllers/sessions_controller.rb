class SessionsController < ApplicationController

  def create
    reset_session
    meet = Meet.where(id: params[:session][:meet_id]).web_pin(params[:session][:web_pin]).first
    if meet.present?
      session[:meet] = meet.token
      redirect_to meet_path(meet)
    else
      redirect_to :back, alert: 'Niepoprawny Pin Lub Brak Transmisji.'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Zostałeś poprawnie wylogowany!'
  end

end
