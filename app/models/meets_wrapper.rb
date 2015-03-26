class MeetsWrapper < AmiWrapper

  def self.users(meet)
    response = connection.command("confbridge list #{meet.identifier}")
    parse_users(response)
  end

  def self.mute(conference, user)
    connection.command("confbridge mute #{conference} #{user}")
  end

  def self.unmute(conference, user)
    #connection.command("confbridge mute #{conference} participants")
    connection.command("confbridge mute #{conference} all")
    connection.command("confbridge unmute #{conference} #{user}")
  end

  protected

  def self.parse_users(response)
    parsed = select_lines(response.data, '==', '--END COMMAND--', 'No conference')
    parsed = parsed.map do |user|
      data = user.split(" ")
      if data.size == 5
        UserWrapper.new(data.last, data.first, false)
      else
        UserWrapper.new(data.last, data.first, data[1].to_s.include?('m'))
      end

    end
  end

  def self.select_lines(response, after_string, before_string, no_results_string)

    parsed = []

    if response.include?(no_results_string)
      return parsed
    end

    after = false
    before = true

    response.split("\n").each do |line|

      line = line.strip.squeeze(' ')
      before = !line.include?(before_string) if before

      if after and before
        parsed << line
      end

      after = line.include?(after_string) unless after
    end

    parsed
  end

end