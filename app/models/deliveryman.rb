class Deliveryman < ApplicationRecord
  has_many :sales

  def self.by_day_sales(day)
    day = day ? Time.strptime(day, '%Y-%m-%d') : Time.now

    joins(:sales)
    .where('sales.created_at BETWEEN ? and ?', day.beginning_of_day, day.end_of_day)
  end
end
