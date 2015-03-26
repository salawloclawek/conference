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
    @@ami = RubyAsterisk::AMI.new("192.168.0.11", 5038)
    @@ami.login("admin", "Zdrojowa13")
  end


  def connection
    AmiWrapper.connection
  end



end