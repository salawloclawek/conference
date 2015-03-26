class Meet < ActiveRecord::Base

  def to_param
    phone_number
  end

  def users(reload=false)
    if reload
      @users = MeetsWrapper.users(self)
    else
      @users ||= MeetsWrapper.users(self)
    end
  end

end
