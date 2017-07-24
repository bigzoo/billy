class CreateTableUserAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table(:user_accounts)do |t|
      t.column(:user_id,:int)
      t.column(:company_account_id,:int)
      t.column(:account_no,:int)
      t.column(:name,:string)
      t.timestamps()
    end
  end
end
