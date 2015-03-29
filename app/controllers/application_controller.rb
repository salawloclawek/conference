class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :check_session

  helper_method :current_meet

  protected

  def check_session
    if session[:meet]
      @current_meet = Meet.token(session[:meet]).includes(phones: [ :key_maps ]).first
    end
  end

  def current_meet
    @current_meet
  end

  def current_meet?
    current_meet
  end

  def not_authorized
    redirect_to root_url, alert: 'Nie masz uprawnień do tej akcji.'
  end

  def require_meet!
    not_authorized if !current_meet or current_meet.phone_number != params[:id]
  end

  def require_meet_params!
    not_authorized if !current_meet or current_meet.phone_number != params[:meet_id]
  end

end
