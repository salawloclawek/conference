class Asterisk::MeetsController < ApplicationController

  def exists
    render text: MeetsWrapper.exists(params), layout: false
  end

  def pin
    render text: MeetsWrapper.pin(params), layout: false
  end

  def phone_number
    render text: MeetsWrapper.phone_number(params), layout: false
  end

  def internal_user_profile
    render text: MeetsWrapper.internal_user_profile(params), layout: false
  end

end
