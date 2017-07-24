class CreateTablePayments < ActiveRecord::Migration[5.1]
  def change
    create_table(:payments)do |t|
      t.column(:user_id,:int)
      t.column(:payment_method_id,:int)
      t.column(:user_account_id,:int)
      t.column(:amount,:int)
      t.column(:company_id,:int)
      t.timestamps()
    end
  end
end
