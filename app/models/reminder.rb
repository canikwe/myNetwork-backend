class Reminder < ApplicationRecord
  belongs_to :contact

  def friend_id
    self.contact.requested.id
  end

  def friend_name
    self.contact.requested.name
  end

  def occurrence
    @occurrence
  end

  def match
    @occurrence = 0
    current = self.start_date
    month_count = 0
    today = Date.today

    while current <= today && self.recurring == true
      if current == today
        return true
      end

      case self.period
      when 'daily'
        current = current.advance(days: self.interval)
        @occurrence++
      when 'monthly'
        month_count += self.interval
        current = self.start_date.advance(months: month_count)
        @occurrence++
      when 'weekly'
        current = current.advance(weeks: self.interval)
        @occurrence++
      when 'yearly'
        current = current.advance(years: self.interval)
        @occurrence++
      end
    end

    return current == today
  
  end


end

