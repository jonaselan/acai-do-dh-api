class Sale < ApplicationRecord
  enum payment_method: { cash: 'cash', credit_card: 'credit_card', pix: 'pix' }
  enum delivery_method: { delivery: 'delivery', in_store: 'in_store' }

  belongs_to :deliveryman, optional: true

  before_validation do
    if self.in_store?
      self.paid = true
      self.receiver = true
    end
  end

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

  def self.by_payment_method(kind)
    if kind
      where(payment_method: kind)
    end
  end
end
