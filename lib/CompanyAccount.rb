class CompanyAccount < ActiveRecord::Base
  belongs_to :company
  belongs_to :user_account
end
