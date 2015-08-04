class Product < ActiveRecord::Base
  validates :name,  presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  belongs_to :user

end
