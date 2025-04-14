class Transaction < ApplicationRecord
  belongs_to :user
  validates :title, presence: { message: "is required" }
  validates :amount, presence: { message: "is required" }
  validates :transaction_type, presence: { message: "is required" }
  validates :category, presence: { message: "is required" }
  

end
