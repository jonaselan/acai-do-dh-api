class Expense < ApplicationRecord
  enum kind: {
    acai: 'acai', complement: 'complement', others: 'others',
    deliveryman: 'deliveryman', employees: 'employees'
   }

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

  def self.by_month(date)
    date = date ? Time.strptime("#{date}-04", '%Y-%m-%d') : Time.now

    where(created_at: date.beginning_of_month..date.end_of_month)
  end
end
