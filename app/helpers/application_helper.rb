module ApplicationHelper

  def inflector_person(count)
    case count.to_i
      when 1 then '1 osoba słucha'
      when 2..4 then "#{count} osoby słuchają"
      else "#{count} osób słucha"
    end
  end

end
