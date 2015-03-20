class UsersController < ApplicationController


  def mute
    MeetsWrapper.mute(params[:meet_id], params[:id])
    render text: 'ok', layout: false
  end

  def unmute
    MeetsWrapper.unmute(params[:meet_id], params[:id])
    render text: 'ok', layout: false
  end

end
