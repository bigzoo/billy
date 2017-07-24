class CreateTableCompanyAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table(:company_accounts)do |t|
      t.column(:company_id,:int)
      t.column(:balance,:int)
      t.column(:due_date,:date)
      t.column(:user_national_id,:int)
      t.column(:user_reg_name,:string)
      t.column(:account_no,:int)
      t.timestamps()
    end
  end
end
