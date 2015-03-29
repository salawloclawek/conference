class Admin::MeetsController < ApplicationController

  http_basic_authenticate_with name: "admin", password: Yetting.admin['password']

  def index
    @meets = Meet.all
  end

  def new
    @meet = Meet.new
  end

  def create
    @meet = Meet.new(meet_attributes)
    if @meet.save
      redirect_to admin_meets_path, notice: 'Pomyślnie dodano nową transmisję.'
    else
      render 'new'
    end
  end

  def edit
    @meet = Meet.phone_number(params[:id]).first
  end

  def update
    @meet = Meet.phone_number(params[:id]).first
    if @meet.update(meet_attributes)
      redirect_to admin_meets_path, notice: 'Pomyślnie zaktualizowano transmisję.'
    else
      render 'edit'
    end
  end

  def destroy
    @meet = Meet.find(params[:id])
    if @meet.destroy
      redirect_to admin_meet_path, notice: 'Pomyślnie usunięto transmisję.'
    else
      redirect_to admin_meet_path, alert: 'Usunięcie transmisji było niemożliwe.'
    end
  end

  protected

  def meet_attributes
    params.require(:meet).permit(
      :name, :phone_number, :sip_number, :admin_id, :web_pin, :pin, :active
    )
  end

end
