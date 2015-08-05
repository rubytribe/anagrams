class Product < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  belongs_to :user
end
