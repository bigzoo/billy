class CreateTableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users)do |t|
      t.column(:national_id,:int)
      t.column(:first_name,:string)
      t.column(:last_name,:string)
      t.column(:email,:string)
      t.column(:username,:string)
      t.column(:password,:string)
      t.column(:image,:varchar)
      t.column(:phone_no,:int)
      t.column(:balance,:int)
      t.timestamps()
    end
  end
end
