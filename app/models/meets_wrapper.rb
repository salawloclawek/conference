class MeetsWrapper < AmiWrapper

  def self.exists(params)
    Meet.sip_number(slice_did(params[:ext])).active.first.present?
  end

  def self.pin(params)

    phone = Phone.phone_number(slice_caller_id(params[:ext])).first
    meet = Meet.sip_number(slice_did(params[:ext])).first

    (phone.present? and phone.auto_join and meet.id == phone.meet_id) ? '' : meet.pin

  end

  def self.phone_number(params)
    Meet.sip_number(slice_did(params[:ext])).first.phone_number
  end

  def self.internal_user_profile(params)

    phone = Phone.phone_number(params[:callerid]).admin.first
    meet = Meet.phone_number(params[:exten]).first

    (phone.present? and meet.present? and meet.admin_id == phone.id) ? 'admin' : 'user'

  end


  def self.users(meet)
    response = connection.command("confbridge list #{meet.phone_number}")
    parse_users(response)
  end

  def self.mute(conference, user)
    connection.command("confbridge mute #{conference} #{user}")
  end

  def self.unmute(conference, user)
    #connection.command("confbridge mute #{conference} participants")
    connection.command("confbridge mute #{conference} all") # admin too

    connection.command("confbridge unmute #{conference} #{user}")
  end

  def self.kick(conference, user)
    connection.command("confbridge kick #{conference} #{user}")
  end

  def self.kick_all(conference)
    connection.command("confbridge kick #{conference} all")
  end

  def self.slice_caller_id(original)
    original.size > 9 ? original.slice(0..-10) : original
  end

  def self.slice_did(original)
    original.reverse[0...9].reverse
  end

  def self.user_bridge(params)

    phone = Phone.phone_number(slice_caller_id(params[:callerid])).first
    meet = Meet.sip_number(params[:did]).first

    if phone.present? and phone.auto_join and meet.id == phone.meet_id
      'user_no_pin'
    else
      "#{meet.asterisk_user_profile_pre}_user"
    end

  end

  def self.parse_users(response)
    parsed = select_lines(response.data, '==', '--END COMMAND--', 'No conference')
    parsed = parsed.map do |user|
      data = user.split(" ")
      if data.size == 5
        PhoneWrapper.new(slice_caller_id(data.last), data.first, false)
      else
        PhoneWrapper.new(slice_caller_id(data.last), data.first, data[1].to_s.include?('m'))
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