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
    def @@ami.public_execute(command, options = {})
      request = RubyAsterisk::Request.new(command, options)
      request.commands.each do |command|
        @session.write(command)
      end
      @session.waitfor('Match' => /ActionID: #{request.action_id}.*?\n\n/m) do |data|
        request.response_data << data
      end
      RubyAsterisk::Response.new(command, request.response_data)
    end
  end


  def connection
    AmiWrapper.connection
  end



end