class Sale < ApplicationRecord
  enum payment_method: { cash: 'cash', credit_card: 'credit_card' }
  enum delivery_method: { delivery: 'delivery', in_store: 'in_store' }

  belongs_to :deliveryman, optional: true

  # scope :by_day, -> (day) {
  #   where(created_at: day.beginning_of_day..day.end_of_day)
  # }

  # scope :paginate, -> (page, per_page) {
  #   offset((page - 1) * per_page)
  #   .limit(per_page)
  #   .order(created_at: :desc)
  # }

  before_validation do
    if self.in_store?
      self.paid = true
      self.receiver = true
    end
  end

  def self.paginate(page, per_page)
    page = [(page || 1).to_i, 1].max
    per_page = per_page.present? ? per_page.to_i : 8

    offset((page - 1) * per_page)
    .limit(per_page)
    .order(created_at: :desc)
  end

  def self.by_day(day)
    day = day ? Time.strptime(day, "%Y-%m-%d") || Time.now

    where(created_at: day.beginning_of_day..day.end_of_day)
  end
end
