class Expense < ApplicationRecord
  def self.paginate(page, per_page)
    page = [(page || 1).to_i, 1].max
    per_page = per_page.present? ? per_page.to_i : 60

    offset((page - 1) * per_page)
    .limit(per_page)
    .order(created_at: :desc)
  end

  def self.by_day(day)
    day = day ? Time.strptime(day, '%Y-%m-%d') : Time.now

    where(created_at: day.beginning_of_day..day.end_of_day)
  end
end
