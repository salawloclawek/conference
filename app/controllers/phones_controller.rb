class PhonesController < ApplicationController

  before_action :require_meet_params!

  def index
    @phones = current_meet.phones.participant.includes(:key_maps)
  end

  def new
    @phone = Phone.new
    @phone.initialize_key_maps
  end

  def create
    @phone = Phone.new(phone_attributes)
    if @phone.save
      redirect_to meet_phones_url(current_meet), notice: 'Pomyślnie dodano nowy numer telefonu.'
    else
      render :new
    end
  end

  def edit
    @phone = current_meet.phones.phone_number(params[:id]).first
  end

  def update
    @phone = current_meet.phones.phone_number(params[:id]).first
    if @phone.update(phone_attributes)
      redirect_to meet_phones_url(current_meet), notice: 'Pomyślnie zmieniono dane.'
    else
      render :edit
    end
  end

  def destroy
    @phone = current_meet.phones.phone_number(params[:id]).first
    if @phone.destroy
      redirect_to meet_phones_url(current_meet), notice: "Pomyślnie usunięto #{@phone.phone_number}."
    else
      redirect_to meet_phones_url(current_meet), alert: "Nie udało się usunąć: #{@phone.phone_number}."
    end
  end

  def mute
    MeetsWrapper.mute(params[:meet_id], params[:id])
    render text: 'ok', layout: false
  end

  def unmute
    MeetsWrapper.unmute(params[:meet_id], params[:id])
    render text: 'ok', layout: false
  end

  def kick
    MeetsWrapper.kick(params[:meet_id], params[:id])
    render text: 'ok', layout: false
  end

  protected

  def phone_attributes
    params[:phone][:meet_id] = current_meet.id
    params.require(:phone).permit(
      :meet_id, :phone_number, :name, :auto_join,
      key_maps_attributes: [ :id, :digit, :name ]
    )
  end

end
