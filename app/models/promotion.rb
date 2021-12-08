class Promotion < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :promo_type, presence: true, inclusion: {in: %w(item_discount)}
end
