class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :payment_method
  belongs_to :user_account
end
