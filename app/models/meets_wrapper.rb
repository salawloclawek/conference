class MeetsWrapper < AmiWrapper

  def self.users(meet)
    response = connection.command("meetme list #{meet.identifier}")
    parse_users(response)
  end

  def self.mute(conference, user)
    connection.command("meetme mute #{conference} #{user}")
  end

  def self.unmute(conference, user)
    connection.command("meetme unmute #{conference} #{user}")
  end

  protected

  def self.parse_users(response)
    parsed = select_lines(response.data, 'ActionID', 'users in that conference', 'No active')
    parsed = parsed.map do |user|
      data = user.split('#:')[1].split(' ')
      UserWrapper.new(data[1], data[0], user.include?('Muted'))
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