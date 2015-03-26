class AmiWrapper

  @@ami = nil

  def self.connection
    begin
      if @@ami.status?
        return @@ami
      end
    rescue
      create_connection
    end
    @@ami
  end

  def self.create_connection
    @@ami = RubyAsterisk::AMI.new(Yetting.ami['host'], Yetting.ami['port'])
    @@ami.login(Yetting.ami['user'], Yetting.ami['password'])
  end


  def connection
    AmiWrapper.connection
  end



end