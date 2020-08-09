class Sale < ApplicationRecord
  enum payment_method: { cash: 'cash', credit_card: 'credit_card' }
  enum delivery_method: { delivery: 'delivery', in_store: 'in_store' }

  belongs_to :deliveryman, optional: true
end
