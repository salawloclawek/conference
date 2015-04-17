module ApplicationHelper

  def inflector_person(count)
    case count.to_i
      when 1 then '1 osoba słucha'
      when 2..4 then "#{count} osoby słuchają"
      else "#{count} osób słucha"
    end
  end

  def phone_number(number)
    "#{number[0]}#{number[1]} #{number[2]}#{number[3]}#{number[4]} #{number[5]}#{number[6]} #{number[7]}#{number[8]}"
  end

end
