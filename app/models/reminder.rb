class Reminder < ApplicationRecord
  belongs_to :contact

  def friend_id
    self.contact.user_id
  end

  def friend_name
    self.contact.name
  end

  def resetSnooze
    if !self.current.nil? && self.current.to_date < DateTime.now.to_date
      self.update(snoozed: false) if self.snoozed
    end
  end

  def expired
    today = DateTime.now.to_date

    if self.end_date.to_date < today
      return true
    else
      return false
    end
  end

  def contact_name
    self.contact.name
  end


  def match
    self.resetSnooze

    current_date = self.start_date.to_date
    month_count = 0
    today = DateTime.now.to_date

    while current_date <= today && self.recurring == true
      if current_date == today
        return true
      elsif self.end_date.to_date < today
        return false
      end

      case self.period
      when 'daily'
        current_date = current_date.advance(days: self.interval)
      when 'monthly'
        month_count += self.interval
        current_date = self.start_date.advance(months: month_count)
      when 'weekly'
        current_date = current_date.advance(weeks: self.interval)
      when 'yearly'
        current_date = current_date.advance(years: self.interval)
      end
    end

    return current_date == today

  end

end
