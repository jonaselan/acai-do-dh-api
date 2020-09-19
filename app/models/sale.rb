class Sale < ApplicationRecord
  enum payment_method: { cash: 'cash', credit_card: 'credit_card' }
  enum delivery_method: { delivery: 'delivery', in_store: 'in_store' }

  belongs_to :deliveryman, optional: true

  scope :make_today, -> (page, per_page) {
    where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    .order(created_at: :desc)
    .offset((page - 1) * per_page)
    .limit(per_page)
  }

  before_validation do
    self.paid = true if self.in_store?
  end
end
