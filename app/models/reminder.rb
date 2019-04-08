class Reminder < ApplicationRecord
  belongs_to :contact

  def friend_id
    self.contact.requested.id
  end

  def friend_name
    self.contact.requested.name
  end

  def match
    current = self.start_date
    month_count = 0
    today = Date.today

    # byebug
    while current <= today
      if current == today
        return true
      end

      case self.period
      when 'monthly'
        month_count += self.interval
        current = self.start_date.advance(months: month_count)
      when 'weekly'
        current = current.advance(weeks: self.interval)
      when 'daily'
        current = current.advance(days: self.interval)
      when 'yearly'
        current = current.advance(years: self.interval)
      end
    end

    return current == today
  
  end


end

