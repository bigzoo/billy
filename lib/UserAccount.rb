class UserAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :company_account
  has_many :payments
end
