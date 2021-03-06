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

  def self.mute(conference, user, options)
    if(options[:unmute_admin])
      admins(conference).each do |sip|
        connection.command("confbridge unmute #{conference} #{sip}")
      end
    end
    connection.command("confbridge mute #{conference} #{PhoneWrapper.full_identifier(user)}")
    connection.public_execute('PlayDTMF', 'Channel' => PhoneWrapper.full_identifier(user), 'Digit' => '9') if options[:beep]
  end

  def self.unmute(conference, user, options)
    connection.command("confbridge mute #{conference} all") # admin too
    connection.public_execute('PlayDTMF', 'Channel' => PhoneWrapper.full_identifier(user), 'Digit' => '1') if options[:beep]
    connection.command("confbridge unmute #{conference} #{PhoneWrapper.full_identifier(user)}")
  end

  def self.kick(conference, user)
    connection.command("confbridge kick #{conference} #{PhoneWrapper.full_identifier(user)}")
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
    parsed = parsed.sort{ |a, b| (b.admin ? 1 : 0) <=> (a.admin ? 1 : 0) }

    parsed

  end

  def self.admins(meet_phone_number)
    parsed = select_lines(connection.command("confbridge list #{meet_phone_number}").data, '==', '--END COMMAND--', 'No conference')
    parsed = parsed.map do |user|
      user.split(" ")[0] if user.include?('admin')
    end
    parsed.compact
    parsed.compact
  end

  def self.participants(meet_phone_number)
    parsed = select_lines(connection.command("confbridge list #{meet_phone_number}").data, '==', '--END COMMAND--', 'No conference')
    parsed = parsed.map do |user|
      user.split(" ")[0] if user.include?('user')
    end
    parsed.compact
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