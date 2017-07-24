class CreateTablePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table(:payment_methods)do |t|
      t.column(:user_id,:int)
      t.column(:name,:string)
      t.column(:acc_no,:varchar)
      t.column(:provider,:string)
      t.timestamps()
    end
  end
end
