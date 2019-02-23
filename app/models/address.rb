class Address < ApplicationRecord
  belongs_to :users
  has_many :order_items
  
  validates_presence_of :address, :city, :state, :zip

  enum nickname: [:home, :work, :other]
end
