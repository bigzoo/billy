class User < ActiveRecord::Base
  has_many :payment_methods
  has_many :user_accounts
  has_many :payments
end
