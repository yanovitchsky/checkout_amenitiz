class Product < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :code, presence: true, uniqueness: true
end
