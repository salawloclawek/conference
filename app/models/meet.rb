class Meet < ActiveRecord::Base

  def to_param
    identifier
  end

  def users(reload=false)
    if reload
      @users = MeetsWrapper.users(self)
    else
      @users ||= MeetsWrapper.users(self)
    end
  end

end
