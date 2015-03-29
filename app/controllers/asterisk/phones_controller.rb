class Asterisk::PhonesController < ApplicationController

  def menu_callback

    PhoneWrapper.menu_callback(params)
    render text: '1', layout: false
  end

end
